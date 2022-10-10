import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

class EditingTextField extends StatelessWidget {
  EditingTextField(
      {Key? key,
      this.hintText,
      this.width,
      required this.textType,
      required this.controller,
      this.onChanged})
      : super(key: key);

  String? hintText;
  double? width;
  TextEditingController controller;
  ValueChanged? onChanged;
  TextInputType textType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        keyboardType: textType,
        onChanged: onChanged ?? (v) {},
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w600),
        cursorColor: MyColors.textColor,
        decoration: InputDecoration(
          hintText: hintText ?? "Hint text",
          hintStyle: const TextStyle(
              color: MyColors.C_95969D, fontWeight: FontWeight.w400),
          fillColor: MyColors.C_F2F2F2,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyColors.C_F2F2F2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: MyColors.C_95969D),
          ),
        ),
      ),
    );
  }
}
