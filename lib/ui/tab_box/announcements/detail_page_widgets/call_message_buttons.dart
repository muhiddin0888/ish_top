// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

class ConnectedButton extends StatelessWidget {
  ConnectedButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.margin,
    required this.isActive,
  }) : super(key: key);

  final Icon icon;
  final String text;
  final VoidCallback onPressed;
  final bool isActive;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: (isActive) ? MyColors.C_356899 : Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: MyColors.C_2C557D,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: (isActive) ? MyColors.white : MyColors.C_2C557D,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 14),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: (isActive) ? MyColors.white : MyColors.C_2C557D,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
