import 'package:flutter/material.dart';
import 'package:ish_top/utils/style.dart';

class SelectLevelWidget extends StatelessWidget {
  SelectLevelWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.text,
  });

  final bool isSelected;
  VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff356899) : null,
          borderRadius: BorderRadius.circular(97),
          border: isSelected
              ? null
              : Border.all(width: 1, color: const Color(0xff95969d)),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 450),
          style: MyTextStyle.sfProMedium.copyWith(
            color: isSelected ? Colors.white : const Color(0xff95969d),
            fontSize: isSelected ? 18 : 14,
          ),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
