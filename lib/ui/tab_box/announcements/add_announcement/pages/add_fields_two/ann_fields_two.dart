// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/data/models/category/category_item.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_from_where.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/widgets/select_level.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/comment_input_componenet.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/select_level.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/widgets/title_text.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/search_text_field.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/my_utils.dart';
import 'package:ish_top/utils/style.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:developer' as print;

class AnnFieldsTwo extends StatefulWidget {
  const AnnFieldsTwo({Key? key}) : super(key: key);

  @override
  State<AnnFieldsTwo> createState() => _AnnFieldsTwoState();
}

class _AnnFieldsTwoState extends State<AnnFieldsTwo> {
  final TextEditingController textEditingController = TextEditingController();
  String selectLevel = "";
  int selectedCategory = 0;
  int selectedCategoryForIcon = -1;
  String selectFromWhereText = "";
  int element = -1;
  List<CategoryItem> searchedCategory = [];
  final TextEditingController searchController = TextEditingController();
  final GlobalKey expansionTile = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectLevel = context.read<AnnouncementCubit>().state.fields['level'];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        TitleForSelectText(
          text: 'Darajangizni tanlang:',
        ),
        SizedBox(height: 5),
        SelectLevelItem(
          selectLevel: selectLevel,
          importSelectedLevel: (value) {
            setState(() {
              selectLevel = value;
            });
          },
        ),
        SizedBox(height: 20),
        TitleForSelectText(
          text: 'Mutaxassisligni tanlang:',
        ),
        SizedBox(height: 5),
        ActiveButton(
            buttonText: "Mutaxassislikni tanlash: 👨🏻‍💻",
            onPressed: () {
              bottomSheet(context);
            }),
        SizedBox(height: 20),
        TitleForSelectText(
          text: 'Ish turini tanlang:',
        ),
        SelectFromWhere(),
        TitleForSelectText(
          text: 'Bilimingiz haqida qisqacha',
        ),
        SizedBox(height: 5),
        CommentInputComponent(
          height: 275,
          hintText: "Ma'lumot kiriting",
          commentFocusNode: FocusNode(),
          textEditingController: textEditingController,
          textButton: TextButton(
              onPressed: () {
                textEditingController.clear();
              },
              child: Text("Tozalash")),
          onChanged: (String value) {
            BlocProvider.of<AnnouncementCubit>(context)
                .updateCurrentItem(fieldValue: value, fieldKey: "knowledge");
          },
        )
      ],
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showBarModalBottomSheet(
      duration: Duration(milliseconds: 650),
      isDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return BlocBuilder<HelperCubit, HelperState>(
              builder: (context, state) {
            if (state is GetCategoriesInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetCategoriesInSuccess) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset("assets/svg/cancel.svg")),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            context
                                .read<AnnouncementCubit>()
                                .state
                                .fields["category_id"] = selectedCategory;
                            searchedCategory.isNotEmpty
                                ? MyUtils.getMyToast(
                                    message:
                                        "${state.categories[element].categoryName} muvaffaqiyatli tanlandi")
                                : MyUtils.getMyToast(
                                    message:
                                        "${state.categories[selectedCategory].categoryName} muvaffaqiyatli tanlandi");
                            Navigator.pop(context);
                            context
                                    .read<AnnouncementCubit>()
                                    .state
                                    .fields["category_id"] =
                                searchedCategory.isNotEmpty
                                    ? element
                                    : selectedCategory;
                          },
                          child: Text("Bajarildi"))
                    ],
                  ),
                  SearchTextField(
                    controller: searchController,
                    onChanged: (value) => {
                      if (value.toString().isEmpty)
                        {
                          selectedCategory = -1,
                          element = -1,
                          selectedCategoryForIcon = -1,
                        },
                      searchedCategory = state.categories
                          .where(
                            (element) =>
                                element.categoryName.toLowerCase().contains(
                                      value.toString().toLowerCase(),
                                    ),
                          )
                          .toList(),
                      setState(
                        () => {},
                      ),
                      print.log(searchedCategory.toString())
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchedCategory.isNotEmpty
                          ? searchedCategory.length
                          : state.categories.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => {
                          selectedCategory = index,
                          setState(
                            () => {
                              if (searchedCategory.isNotEmpty)
                                {
                                  for (int i = 0;
                                      i < state.categories.length;
                                      i++)
                                    {
                                      if (state.categories[i].categoryName ==
                                          searchedCategory[selectedCategory]
                                              .categoryName)
                                        {
                                          element = i,
                                          selectedCategoryForIcon = index
                                        }
                                    },
                                },
                              context
                                  .read<AnnouncementCubit>()
                                  .state
                                  .fields["category_id"] = selectedCategory,
                            },
                          ),
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 70,
                            child: Image.network(
                              searchedCategory.isNotEmpty
                                  ? searchedCategory[index].icon
                                  : state.categories[index].icon,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(searchedCategory.isNotEmpty
                              ? searchedCategory[index].categoryName
                              : state.categories[index].categoryName),
                          subtitle: Text(searchedCategory.isNotEmpty
                              ? searchedCategory[index].description
                              : state.categories[index].description),
                          trailing: IconButton(
                            icon: searchedCategory.isNotEmpty
                                ? selectedCategoryForIcon == index
                                    ? Icon(
                                        Icons.circle,
                                        color: Color(0xff356899),
                                      )
                                    : Icon(
                                        Icons.circle_outlined,
                                        color: Color(0xff356899),
                                      )
                                : selectedCategory == index
                                    ? Icon(
                                        Icons.circle,
                                        color: Color(0xff356899),
                                      )
                                    : Icon(
                                        Icons.circle_outlined,
                                        color: Color(0xff356899),
                                      ),
                            onPressed: () => {
                              selectedCategory = index,
                              if (searchedCategory.isNotEmpty)
                                {
                                  for (int i = 0;
                                      i < state.categories.length;
                                      i++)
                                    {
                                      if (state.categories[i].categoryName ==
                                          searchedCategory[selectedCategory]
                                              .categoryName)
                                        {
                                          element = i,
                                        }
                                    },
                                },
                              setState(() => {}),
                              context
                                  .read<AnnouncementCubit>()
                                  .state
                                  .fields["category_id"] = selectedCategory,
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              );
            } else if (state is GetCategoriesInFailure) {
              return Text(state.errorText);
            } else {
              return SizedBox();
            }
          });
        },
      ),
    );
  }
}
