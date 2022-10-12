import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_category_bottom_sheet.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_from_where.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_level.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/comment_input_componenet.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/widgets/title_text.dart';
import 'package:ish_top/ui/widgets/active_button.dart';

class AnnFieldsTwo extends StatefulWidget {
  const AnnFieldsTwo({Key? key}) : super(key: key);

  @override
  State<AnnFieldsTwo> createState() => _AnnFieldsTwoState();
}

class _AnnFieldsTwoState extends State<AnnFieldsTwo> {
  final TextEditingController textEditingController = TextEditingController();
  String selectLevel = "";
  String selectFromWhereText = "";

  @override
  void initState() {
    super.initState();
    textEditingController.text =
        context.read<AnnouncementCubit>().state.fields['knowledge'];
    selectLevel = context.read<AnnouncementCubit>().state.fields['level'];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const TitleForSelectText(
          text: 'Darajangizni tanlang:',
        ),
        const SizedBox(height: 5),
        SelectLevelItem(
          selectLevel: selectLevel,
          importSelectedLevel: (value) {
            setState(() {
              selectLevel = value;
            });
          },
        ),
        const SizedBox(height: 20),
        const TitleForSelectText(
          text: 'Mutaxassisligni tanlang:',
        ),
        const SizedBox(height: 5),
        ActiveButton(
            buttonText: "Mutaxassislikni tanlash: 👨🏻‍💻",
            onPressed: () {
              selectCategoryBottomSheet(context);
            }),
        const SizedBox(height: 20),
        const TitleForSelectText(
          text: 'Ish turini tanlang:',
        ),
        const SelectFromWhere(),
        const TitleForSelectText(
          text: 'Bilimingiz haqida qisqacha',
        ),
        const SizedBox(height: 5),
        CommentInputComponent(
          height: 275,
          hintText: "Ma'lumot kiriting",
          commentFocusNode: FocusNode(),
          textEditingController: textEditingController,
          textButton: TextButton(
              onPressed: () {
                textEditingController.clear();
                BlocProvider.of<AnnouncementCubit>(context)
                    .updateCurrentItem(fieldValue: "", fieldKey: "knowledge");
              },
              child: const Text("Tozalash")),
          onChanged: (String value) {
            BlocProvider.of<AnnouncementCubit>(context)
                .updateCurrentItem(fieldValue: value, fieldKey: "knowledge");
          },
        )
      ],
    );
  }
}
