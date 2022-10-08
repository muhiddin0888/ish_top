import 'package:flutter/material.dart';
import 'package:ish_top/utils/style.dart';

class SelectLevelWidget extends StatelessWidget {
  SelectLevelWidget(
      {super.key,
      required this.onTap,
      required this.backGroundColor,
      required this.border,
      required this.textColor,
      required this.text});

  VoidCallback onTap;
  Color? backGroundColor;
  BoxBorder? border;
  Color textColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(97),
          border: border,
        ),
        child: Text(
          text,
          style: MyTextStyle.sfProMedium.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
