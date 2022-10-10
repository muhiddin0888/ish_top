// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/data/models/category/category_item.dart';
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
  int selectLevel = 0;
  int selectedCategory = 0;
  int selectedCategoryForIcon = -1;
  int selectedFromWhere = 1;
  String selectFromWhereText = "";
  int element = -1;
  List<CategoryItem> searchedCategory = [];
  final TextEditingController searchController = TextEditingController();
  final GlobalKey expansionTile = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TitleForSelectText(
          text: 'Darajangizni tanlang:',
        ),
        SizedBox(height: 5),
        selectLevels(context),
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
        selectTile(),
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
            context.read<AnnouncementCubit>().state.fields["knowledge"] = value;
          },
        )
      ],
    );
  }

  ExpansionTile selectTile() {
    return ExpansionTile(
      key: UniqueKey(),
      title: Text(
        selectFromWhereText == ""
            ? "Qayerdan turib ishlaysiz"
            : selectFromWhereText,
        style: MyTextStyle.sfProMedium.copyWith(
          fontSize: 18,
          color:
              selectFromWhereText == "" ? MyColors.C_2C557D : MyColors.C_039D57,
        ),
      ),
      children: [
        TextButton(
          onPressed: () {
            selectedFromWhere = 1;
            selectFromWhereText = "Uydan";
            context.read<AnnouncementCubit>().state.fields["from_where"] =
                selectedFromWhere;
            setState(
              () => {},
            );
          },
          child: Text(
            "Uydan",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            selectedFromWhere = 2;
            selectFromWhereText = "Ofisdan";
            context.read<AnnouncementCubit>().state.fields["from_where"] =
                selectedFromWhere;
            setState(
              () => {},
            );
          },
          child: Text(
            "Ofisdan",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            selectedFromWhere = 3;
            selectFromWhereText = "Har qanday";
            context.read<AnnouncementCubit>().state.fields["from_where"] =
                selectedFromWhere;
            setState(
              () => {},
            );
          },
          child: Text(
            "Har qanday",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
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

  SizedBox selectLevels(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SelectLevelWidget(
            onTap: () {
              selectLevel = 0;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Internship";
            },
            backGroundColor: selectLevel == 0 ? Color(0xff356899) : null,
            border: selectLevel == 0
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor: selectLevel == 0 ? Colors.white : Color(0xff95969d),
            text: selectLevel == 0 ? 'Internship 👶' : 'Internship',
            textSize: selectLevel == 0 ? 18 : 14,
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: selectLevel == 1 ? 18 : 14,
            onTap: () {
              selectLevel = 1;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Junior";
            },
            backGroundColor: selectLevel == 1 ? Color(0xff356899) : null,
            border: selectLevel == 1
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor: selectLevel == 1 ? Colors.white : Color(0xff95969d),
            text: selectLevel == 1 ? 'Junior 👦' : 'Junior',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: selectLevel == 2 ? 18 : 14,
            onTap: () {
              selectLevel = 2;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Middle";
            },
            backGroundColor: selectLevel == 2 ? Color(0xff356899) : null,
            border: selectLevel == 2
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor: selectLevel == 2 ? Colors.white : Color(0xff95969d),
            text: selectLevel == 2 ? 'Middle 👨' : 'Middle',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: selectLevel == 3 ? 18 : 14,
            onTap: () {
              selectLevel = 3;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Senior";
            },
            backGroundColor: selectLevel == 3 ? Color(0xff356899) : null,
            border: selectLevel == 3
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor: selectLevel == 3 ? Colors.white : Color(0xff95969d),
            text: selectLevel == 3 ? 'Senior 👨‍🦱' : 'Senior',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: selectLevel == 4 ? 18 : 14,
            onTap: () {
              selectLevel = 4;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Expert";
            },
            backGroundColor: selectLevel == 4 ? Color(0xff356899) : null,
            border: selectLevel == 4
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor: selectLevel == 4 ? Colors.white : Color(0xff95969d),
            text: selectLevel == 4 ? 'Expert 👨‍🦲' : 'Expert',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: selectLevel == 5 ? 18 : 14,
            onTap: () {
              selectLevel = 5;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Team Lead";
            },
            backGroundColor: selectLevel == 5 ? Color(0xff356899) : null,
            border: selectLevel == 5
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor: selectLevel == 5 ? Colors.white : Color(0xff95969d),
            text: selectLevel == 5 ? 'Team Lead 👨‍💻' : 'Team Lead',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: selectLevel == 6 ? 18 : 14,
            onTap: () {
              selectLevel = 6;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Project Manager";
            },
            backGroundColor: selectLevel == 6 ? Color(0xff356899) : null,
            border: selectLevel == 6
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor: selectLevel == 6 ? Colors.white : Color(0xff95969d),
            text: selectLevel == 6 ? 'Project Manager 👴' : 'Project Manager',
          ),
        ],
      ),
    );
  }
}
