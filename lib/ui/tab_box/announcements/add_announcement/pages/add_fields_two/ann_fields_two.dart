import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/data/models/category/category_item.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/category_select_item.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_category_bottom_sheet.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_from_where.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_level.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/comment_input_componenet.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/widgets/title_text.dart';

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
      physics: BouncingScrollPhysics(),
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
        const TitleForSelectText(text: 'Mutaxassisligni tanlang:'),
        const SizedBox(height: 5),
        BlocBuilder<HelperCubit, HelperState>(
          builder: (context, state) {
            if (state is GetCategoriesInSuccess) {
              var list = state.categories
                  .where((element) =>
                      (BlocProvider.of<AnnouncementCubit>(context)
                          .state
                          .fields["category_id"]) ==
                      element.categoryId)
                  .toList();

              CategoryItem? categoryItem = list.isNotEmpty ? list.first : null;
              return CategorySelectItem(
                onTap: () {
                  selectCategoryBottomSheet(
                    onChanged: () {
                      setState(() {});
                    },
                    context: context,
                  );
                },
                categoryItem: categoryItem,
              );
            }
            return const SizedBox();
          },
        ),
        const SizedBox(height: 20),
        const TitleForSelectText(text: 'Ish turini tanlang:'),
        const SelectFromWhere(),
        const TitleForSelectText(text: 'Bilimingiz haqida qisqacha'),
        const SizedBox(height: 15),
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
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
