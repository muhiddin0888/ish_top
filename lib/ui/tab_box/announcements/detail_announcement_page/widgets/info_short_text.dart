import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class InfoShortText extends StatelessWidget {
  final String title;
  final info;
  const InfoShortText({super.key, required this.info, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            title,
            style: MyTextStyle.sfProBold
                .copyWith(fontSize: 16, color: MyColors.C_95969D),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              info,
              textAlign: TextAlign.end,
              style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
