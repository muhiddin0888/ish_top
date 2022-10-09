import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class CommentInputComponent extends StatelessWidget {
  const CommentInputComponent(
      {Key? key, required this.commentText, required this.commentFocusNode})
      : super(key: key);
  final ValueChanged<String> commentText;
  final FocusNode commentFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: MyColors.C_F2F2F2,
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
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
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "Comment",
          hintStyle: MyTextStyle.sfProMedium.copyWith(
            fontSize: 16,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        cursorColor: MyColors.white,
      ),
    );
  }
}
