import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

class CategoryItemButton extends StatelessWidget {
  CategoryItemButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.isActive = false,
    this.icon,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;
  final bool isActive;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      decoration: BoxDecoration(
        border: Border.all(
            color: (isActive) ? MyColors.C_356899 : MyColors.C_95969D),
        borderRadius: BorderRadius.circular(100),
        color: (isActive) ? MyColors.C_356899 : Colors.transparent,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          primary: (isActive) ? Colors.white : Colors.grey.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            SizedBox(width: (icon != null) ? 5 : 0),
            Text(
              buttonText,
              style: TextStyle(
                color: (isActive) ? Colors.white : MyColors.C_95969D,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
