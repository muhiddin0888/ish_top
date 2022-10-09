import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

class SelectableButton extends StatelessWidget {
  SelectableButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isActive = false,
    this.margin,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final bool isActive;
  final VoidCallback onPressed;
  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.shade300,
            offset: const Offset(1, 3),
          )
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 14),
            Text(text, style: const TextStyle(fontSize: 16, color: Colors.black)),
            const Expanded(child: SizedBox()),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: (isActive) ? MyColors.C_356899 : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: (isActive) ? MyColors.C_356899 : MyColors.C_CACBCE),
              ),
              child: (isActive)
                  ? const Center(child: Icon(Icons.done, color: Colors.white, size: 15))
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
