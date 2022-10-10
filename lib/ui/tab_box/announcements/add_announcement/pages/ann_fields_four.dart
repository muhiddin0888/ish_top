import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/my_container.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/url_container.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/selectable_field.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/my_utils.dart';
import 'package:ish_top/utils/style.dart';

class AnnFieldsFour extends StatefulWidget {
  const AnnFieldsFour({Key? key}) : super(key: key);

  @override
  State<AnnFieldsFour> createState() => _AnnFieldsFourState();
}

class _AnnFieldsFourState extends State<AnnFieldsFour> {
  PlatformFile? pickedFile;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String cvUrl = context.read<AnnouncementCubit>().state.fields['cv_url'];
    return ListView(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [10, 20],
          strokeWidth: 2,
          color: MyColors.buttonColor,
          radius: const Radius.circular(25),
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: 340,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  "Upload your CV or Resume and \n use it when you apply for jobs",
                  style: MyTextStyle.sfProLight.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: cvUrl != ""
                            ? UrlContainer(
                                title: pickedFile != null
                                    ? pickedFile!.name
                                    : "PDF has uploaded",
                                subTitle: pickedFile != null
                                    ? "${(pickedFile!.size / 1000000).toStringAsFixed(1)} mb"
                                    : "Unknown mb",
                                onTap: () async {
                                  if (pickedFile != null) {
                                    bool isDeleted = await context
                                        .read<HelperRepository>()
                                        .deleteCv(cvUrl: pickedFile!.name);
                                    if (isDeleted) {
                                      context
                                          .read<AnnouncementCubit>()
                                          .updateCurrentItem(
                                            fieldValue: '',
                                            fieldKey: "cv_url",
                                          );
                                      setState(() {});
                                    } else {
                                      MyUtils.getMyToast(
                                          message: "Something went wrong");
                                    }
                                  } else {
                                    MyUtils.getMyToast(
                                        message: "Can not remove");
                                  }
                                },
                              )
                            : const MyContainer(text: "Upload a PDF"),
                      ),
                const SizedBox(height: 20),
                Visibility(
                  visible: !isLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: ActiveButton(
                      buttonText: 'Upload',
                      onPressed: () async {
                        await selectFile();
                      },
                    ),
                  ),
                )
              ],
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

  Future<void> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        isLoading = true;
      });
      pickedFile = result.files.first;
      String downloadUrl =
          await context.read<HelperRepository>().uploadFile(pickedFile!);
      context.read<AnnouncementCubit>().updateCurrentItem(
            fieldValue: downloadUrl,
            fieldKey: "cv_url",
          );
    } else {
      MyUtils.getMyToast(message: "File not picked");
    }
    setState(() {
      isLoading = false;
    });
  }
}
