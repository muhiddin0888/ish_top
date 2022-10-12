import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class SalaryContainer extends StatelessWidget {
  SalaryContainer(
      {super.key,
      required this.salaryText,
      required this.height,
      required this.radius});
  final String salaryText;
  double height;
  double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: MyColors.C_356899,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: MyColors.textColor, width: 1),
      ),
      child: Center(
        child: Text(
          "Maosh: $salaryText",
          style: MyTextStyle.sfProSemibold
              .copyWith(fontSize: 20, color: MyColors.white),
        ),
      ),
    );
  }
}
