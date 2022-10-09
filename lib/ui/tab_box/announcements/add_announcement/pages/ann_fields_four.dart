import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/my_container.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/selectable_field.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

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
                const MyContainer(text: 'Upload a Doc/Docx/PDF',), // Upload a Doc/Docx/PDF
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ActiveButton(
                    buttonText: 'Upload',
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
        SelectableField(items: const ["PartTime", "FullTime"], onChanged: (String value) {
          context.read<AnnouncementCubit>().updateCurrentItem(
            fieldValue: value,
            fieldKey: "time_to_contact",
          );
        },)
      ],
    );
  }
}
// Yes oxshadi boshqa endi bunaqa qimen Ozi
// boldi rahamat endi hozir push qililik o'zimizani branchga
// ok man orgataman
// Birinchi bolib branch tanlimiz
// Mana ozimizni branchda turibmiz endi push and commit qilamiz
// commit and push qilamiz