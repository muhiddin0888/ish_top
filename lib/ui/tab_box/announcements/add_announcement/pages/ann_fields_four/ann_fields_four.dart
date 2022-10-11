import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/cv_url/cv_url_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/ann_fields_four/widgets/my_container.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/ann_fields_four/widgets/url_container.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/selectable_field.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/my_utils.dart';
import 'package:ish_top/utils/style.dart';
import 'package:flutter/material.dart';

class AnnFieldsFour extends StatefulWidget {
  const AnnFieldsFour({Key? key}) : super(key: key);

  @override
  State<AnnFieldsFour> createState() => _AnnFieldsFourState();
}

class _AnnFieldsFourState extends State<AnnFieldsFour> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: const [10, 20],
            strokeWidth: 2,
            color: MyColors.buttonColor,
            radius: const Radius.circular(25),
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 340,
              width: double.infinity,
              child: BlocConsumer<CvUrlCubit, CvUrlState>(
                listener: (context, state) {
                  MyUtils.getMyToast(message: state.errorText);
                },
                listenWhen: (previous, current) {
                  return current.status == FormzStatus.submissionFailure;
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Upload your CV or Resume and\nuse it when you apply for jobs",
                        style: MyTextStyle.sfProLight.copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible:
                            state.status == FormzStatus.submissionInProgress,
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SpinKitWave(
                                size: 40,
                                color: MyColors.buttonColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            state.status != FormzStatus.submissionInProgress,
                        child: state.cvUrl.isEmpty
                            ? const MyContainer(text: "Upload a PDF")
                            : Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    UrlContainer(
                                      onTap: () async =>
                                          context.read<CvUrlCubit>().deleteCv(),
                                      title: state.cvUrl.fileName,
                                      subTitle: state.cvUrl.sizeOfFile,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Visibility(
                          visible: state.cvUrl.isEmpty,
                          child: ActiveButton(
                            buttonText: 'Upload',
                            onPressed: () async =>
                                context.read<CvUrlCubit>().selectAndUploadCv(),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        SelectableField(
          items: const ["Part time", "Full time", "Any"],
          onChanged: (int value) {
            context.read<AnnouncementCubit>().state.fields['job_type'] = value;
          },
        ),
      ],
    );
  }
}
