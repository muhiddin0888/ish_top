import 'package:flutter/material.dart';
import 'package:ish_top/utils/style.dart';

class TitleForSelectText extends StatelessWidget {
  const TitleForSelectText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: MyTextStyle.sfProBold.copyWith(fontSize: 18));
  }
}
