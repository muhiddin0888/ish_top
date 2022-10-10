import 'package:flutter/material.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/utils/color.dart';

GestureDetector ProfileItem(double width, double height, UserState state, Widget text, VoidCallback voidCallback) {
  return GestureDetector(
    
    onTap: voidCallback,
    child: Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: MyColors.buttonColor, borderRadius: BorderRadius.circular(20)),
      width: width * .9,
      height: height * .08,
      child: Center(
        child: text
      ),
    ),
  );
}