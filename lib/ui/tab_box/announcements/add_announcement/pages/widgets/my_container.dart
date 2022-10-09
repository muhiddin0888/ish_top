

import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    Key? key, required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.C_F2F2F2),
      child: Center(
        child: Text(
          text,
          style: MyTextStyle.sfProSemibold
              .copyWith(color: MyColors.buttonColor, fontSize: 20),
        ),
      ),
    );
  }
}
