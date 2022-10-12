// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/cubits/user_detail/user_detail_cubit.dart';
import 'package:ish_top/data/api_services/pdf_viewer/pdf_viewer.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';
import 'package:ish_top/data/models/users/user_model.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';
import 'package:ish_top/ui/tab_box/announcements/detail_page_widgets/call_message_buttons.dart';
import 'package:ish_top/ui/tab_box/announcements/detail_page_widgets/info_long_text.dart';
import 'package:ish_top/ui/tab_box/announcements/detail_page_widgets/info_short_text.dart';
import 'package:ish_top/ui/tab_box/announcements/pdf_view.dart';
import 'package:ish_top/ui/widgets/custom_app_bar.dart';
import 'package:ish_top/ui/widgets/passive_button.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as printt;

class DetailAnnouncementsPage extends StatefulWidget {
  const DetailAnnouncementsPage({
    Key? key,
    required this.announcementModel,
    required this.helperRepository,
    required this.users,
  }) : super(key: key);
  final AnnouncementModel announcementModel;
  final HelperRepository helperRepository;
  final List<UserModel> users;

  @override
  State<DetailAnnouncementsPage> createState() =>
      _DetailAnnouncementsPageState();
}

class _DetailAnnouncementsPageState extends State<DetailAnnouncementsPage> {
  @override
  void initState() {
    BlocProvider.of<UserDetailCubit>(context).getUserImageById(
        announcement: widget.announcementModel, users: widget.users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Ba'tafsil ma'lumotlar",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                BlocBuilder<UserDetailCubit, UserDetailState>(
                  builder: (context, state) {
                    if (state.status == FormzStatus.submissionInProgress) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == FormzStatus.submissionFailure) {
                      printt.log("error");
                      return Center(
                        child: Text("Error"),
                      );
                    } else if (state.status == FormzStatus.submissionSuccess) {
                      printt.log("success");
                      return CircleAvatar(
                          radius: 40,
                          child: Image.network(
                            context.read<UserDetailCubit>().image,
                            width: 60,
                            fit: BoxFit.cover,
                          ));
                    } else {
                      printt.log("Nimadir Xato");
                      return Text("Nimadir xato");
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.announcementModel.fullName,
                        style: MyTextStyle.sfBold800.copyWith(fontSize: 20),
                      ),
                      Text(
                        "Kasb: ${widget.announcementModel.jobTitle}",
                        style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                      ),
                      Text(
                        "Daraja: ${widget.announcementModel.level}",
                        style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            PassiveButton(
              buttonText: "Resumeni ko'rish",
              onPressed: () async {
                const url =
                    "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf";
                final file = await ApiProvider.loadNetwork(url);
                openPdf(context, file);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Asosiy malumotlar",
                style: MyTextStyle.sfBold800.copyWith(fontSize: 20)),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: MyColors.C_95969D.withOpacity(0.5),
              height: 1,
              width: double.infinity,
            ),
            Expanded(
              child: ListView(
                children: [
                  InfoShortText(
                      info: widget.announcementModel.fullName, title: "F.I.SH"),
                  InfoShortText(
                    info: widget.announcementModel.age.toString(),
                    title: 'Yosh',
                  ),
                  InfoShortText(
                    title: "Daraja",
                    info: widget.announcementModel.level,
                  ),
                  InfoShortText(
                    title: "Telegram",
                    info: widget.announcementModel.telegramUrl,
                  ),
                  InfoShortText(
                      info: widget.announcementModel.timeToContact,
                      title: "Bog'lanish vaqti"),
                  InfoShortText(
                      info: widget.announcementModel.jobTitle, title: "Kasb"),
                  InfoShortText(
                      info: widget.announcementModel.address, title: "Manzil"),
                  InfoShortText(
                      info: widget.announcementModel.phoneNumber,
                      title: "Telefon raqam"),
                  InfoShortText(
                      info: widget.announcementModel.expectedSalary,
                      title: "Maosh"),
                  InfoShortText(
                      info: widget.announcementModel.fromWhere == 0
                          ? "Ofisdan"
                          : widget.announcementModel.fromWhere == 1
                              ? "Uydan"
                              : "Har qanday",
                      title: "Qayerdan turib ishlash"),
                  widget.announcementModel.aim.length > 25
                      ? InfoLongText(
                          info: widget.announcementModel.aim, title: "Maqsad")
                      : InfoShortText(
                          info: widget.announcementModel.aim, title: "Maqsad"),
                  widget.announcementModel.description.length > 25
                      ? InfoLongText(
                          info: widget.announcementModel.description,
                          title: "Tavsif")
                      : InfoShortText(
                          info: widget.announcementModel.description,
                          title: "Tavsif"),
                  widget.announcementModel.knowledge.length > 25
                      ? InfoLongText(
                          info: widget.announcementModel.knowledge,
                          title: "Ko'nikmalar")
                      : InfoShortText(
                          info: widget.announcementModel.knowledge,
                          title: "Ko'nikmalar"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ConnectedButton(
                    icon: Icon(Icons.call),
                    text: "Qo'ng'iroq qilish",
                    onPressed: () {
                      launchUrl(Uri.parse(
                          "tel://${widget.announcementModel.phoneNumber}"));
                    },
                    isActive: false),
                ConnectedButton(
                    icon: Icon(Icons.message),
                    text: "Message",
                    onPressed: () {
                      final uri =
                          "sms:${widget.announcementModel.phoneNumber}?&body=Ish Top zo'r";
                      launchUrl(Uri.parse(uri));
                    },
                    isActive: true),
              ],
            )
          ],
        ),
      ),
    );
  }

  void openPdf(BuildContext context, File file) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewPage(
            file: file,
          ),
        ),
      );
}
