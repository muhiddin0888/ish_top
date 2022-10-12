import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

// ignore: must_be_immutable
class MyCustomInput extends StatelessWidget {
  const MyCustomInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.keyType,
  }) : super(key: key);

  final TextEditingController textEditingController;

  final String hintText;
  final TextInputType keyType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyType,
      controller: textEditingController,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: false,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: MyColors.C_95969D),
          ),
          hintStyle: const TextStyle(
              color: MyColors.C_95969D, fontWeight: FontWeight.w400)),
    );
  }
}
