// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

//Tozalash degan button qo'shdim, null qib berganman xolaselar ishlatib ko'rilar kerak bo'lib qosa
class CommentInputComponent extends StatelessWidget {
  const CommentInputComponent({
    Key? key,
    required this.commentText,
    required this.commentFocusNode,
    this.textEditingController,
    this.textButton,
  }) : super(key: key);
  final ValueChanged<String> commentText;
  final FocusNode commentFocusNode;
  final TextEditingController? textEditingController;
  final Widget? textButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(children: [
        TextField(
          controller: textEditingController,
          expands: true,
          minLines: null,
          maxLines: null,
          textInputAction: TextInputAction.done,
          // focusNode: commentFocusNode,

          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 16, color: MyColors.black),
          onChanged: commentText,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.C_2C557D, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.C_95969D)),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: "Ma'lumot kiriting",
            hintStyle: MyTextStyle.sfProMedium
                .copyWith(fontSize: 16, color: MyColors.C_2C557D),
          ),
          cursorColor: MyColors.C_2C557D,
        ),
        Align(alignment: Alignment.topRight, child: textButton ?? SizedBox()),
      ]),
    );
  }
}
