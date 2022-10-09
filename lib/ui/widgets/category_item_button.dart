import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

class CategoryItemButton extends StatelessWidget {
  CategoryItemButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      decoration: BoxDecoration(
        border: Border.all(color: (isActive) ? MyColors.C_356899 : MyColors.C_95969D),
        borderRadius: BorderRadius.circular(100),
        color: (isActive) ? MyColors.C_356899 : Colors.transparent,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          primary: (isActive) ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: (isActive) ? Colors.white : MyColors.C_95969D,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
