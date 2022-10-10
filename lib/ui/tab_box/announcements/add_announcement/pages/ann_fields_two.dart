// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:developer' as print;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/comment_input_componenet.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/select_level.dart';
import 'package:ish_top/utils/style.dart';

class AnnFieldsTwo extends StatefulWidget {
  const AnnFieldsTwo({Key? key}) : super(key: key);

  @override
  State<AnnFieldsTwo> createState() => _AnnFieldsTwoState();
}

class _AnnFieldsTwoState extends State<AnnFieldsTwo> {
  final TextEditingController textEditingController = TextEditingController();
  int selectLevel = 1;
  int selectCategory = 0;
  int selectedJobTypeId = 1;
  String selectJobType = "";
  final GlobalKey expansionTile = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Darajangizni tanlang:",
          style: MyTextStyle.sfProBold.copyWith(fontSize: 18),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectLevelWidget(
              onTap: () {
                selectLevel = 1;
                setState(
                  () => {},
                );
              },
              backGroundColor: selectLevel == 1 ? Color(0xff356899) : null,
              border: selectLevel == 1
                  ? null
                  : Border.all(width: 1, color: Color(0xff95969d)),
              textColor: selectLevel == 1 ? Colors.white : Color(0xff95969d),
              text: 'Junior',
            ),
            SizedBox(width: 5),
            SelectLevelWidget(
              onTap: () {
                selectLevel = 2;
                setState(
                  () => {},
                );
              },
              backGroundColor: selectLevel == 2 ? Color(0xff356899) : null,
              border: selectLevel == 2
                  ? null
                  : Border.all(width: 1, color: Color(0xff95969d)),
              textColor: selectLevel == 2 ? Colors.white : Color(0xff95969d),
              text: 'Middle',
            ),
            SizedBox(width: 5),
            SelectLevelWidget(
              onTap: () {
                selectLevel = 3;
                setState(
                  () => {},
                );
              },
              backGroundColor: selectLevel == 3 ? Color(0xff356899) : null,
              border: selectLevel == 3
                  ? null
                  : Border.all(width: 1, color: Color(0xff95969d)),
              textColor: selectLevel == 3 ? Colors.white : Color(0xff95969d),
              text: 'Senior',
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          "Categoriyani tanlang:",
          style: MyTextStyle.sfProBold.copyWith(fontSize: 18),
        ),
        SizedBox(height: 15),
        BlocBuilder<HelperCubit, HelperState>(builder: (context, state) {
          if (state is GetCategoriesInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetCategoriesInSuccess) {
            print.log(">>${state.categories[0].description}");
            return Column(
              children: List.generate(state.categories.length, (index) {
                return InkWell(
                  onTap: () => {
                    setState(
                      () => {},
                    ),
                    selectCategory = index
                  },
                  child: ListTile(
                    leading: SizedBox(
                      height: 70,
                      child: Image.network(
                        state.categories[index].icon,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(state.categories[index].categoryName),
                    subtitle: Text(state.categories[index].description),
                    trailing: IconButton(
                      icon: selectCategory == index
                          ? Icon(
                              Icons.circle,
                              color: Color(0xff356899),
                            )
                          : Icon(
                              Icons.circle_outlined,
                              color: Color(0xff356899),
                            ),
                      onPressed: () => {
                        selectCategory = index,
                        setState(
                          () => {},
                        )
                      },
                    ),
                  ),
                );
              }),
            );
          } else if (state is GetCategoriesInFailure) {
            return Text(state.errorText);
          } else {
            return SizedBox();
          }
        }),
        ExpansionTile(
          key: UniqueKey(),
          title: Text(
            selectJobType == "" ? "Ish turini tanlang" : selectJobType,
            style: MyTextStyle.sfProMedium
                .copyWith(fontSize: 18, color: Color(0xfff46d73)),
          ),
          children: [
            TextButton(
              onPressed: () {
                selectedJobTypeId = 1;
                selectJobType = "Online";
                setState(
                  () => {},
                );
              },
              child: Text(
                "Online",
                style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                selectedJobTypeId = 2;
                selectJobType = "Offline";
                setState(
                  () => {},
                );
              },
              child: Text(
                "Offline",
                style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                selectedJobTypeId = 3;
                selectJobType = "Hybrid";
                setState(
                  () => {},
                );
              },
              child: Text(
                "Hybrid",
                style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
        Text(
          "Bilimingiz haqida qisqacha:",
          style: MyTextStyle.sfProBold.copyWith(fontSize: 18),
        ),
        SizedBox(height: 10),
        CommentInputComponent(
          height: 250,
          hintText: "Ma'lumot kiriting",
          onChanged: (String value) {},
          commentFocusNode: FocusNode(),
          textEditingController: textEditingController,
          textButton: TextButton(
              onPressed: () {
                textEditingController.clear();
              },
              child: Text("Tozalash")),
        )
      ],
    );
  }
}
