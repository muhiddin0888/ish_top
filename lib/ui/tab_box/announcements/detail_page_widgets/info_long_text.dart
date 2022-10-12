import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class InfoLongText extends StatelessWidget {
  final dynamic info;
  final String title;
  const InfoLongText({super.key, required this.info, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MyTextStyle.sfProBold
                .copyWith(color: MyColors.C_95969D, fontSize: 18),
          ),
          Text(
            info,
            style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
