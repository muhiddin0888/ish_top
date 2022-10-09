import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({Key? key, this.hintText, this.width, required this.controller, this.onChanged}) : super(key: key);

  String? hintText;
  double? width;
  final TextEditingController controller;
  ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        onChanged: onChanged ?? (v){},
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w600),
        cursorColor: MyColors.textColor,
        decoration: InputDecoration(
          hintText: hintText ?? "Search a job or position",
          hintStyle: const TextStyle(color: MyColors.C_95969D, fontWeight: FontWeight.w400),
          fillColor: MyColors.C_F2F2F2,
          filled: true,
          prefixIcon: SizedBox(
            width: 17,
            height: 17,
            child: Center(
              child: SvgPicture.asset(MyIcons.search),
            ),
          ),
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
