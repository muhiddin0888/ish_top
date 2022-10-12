import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class DescItem extends StatelessWidget {
  const DescItem({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(primary: MyColors.C_356899),
      child: Text(text, style: (isSelected) ? MyTextStyle.sfProBold : MyTextStyle.sfProRegular),
    );
  }
}
