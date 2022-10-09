import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:ish_top/utils/style.dart';

class SixthOnBoardingPage extends StatelessWidget {
  const  SixthOnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            MyIcons.boardingImage6,
          ),
        ),
        Text(
          "Search your dream job fast and ease",
          style: MyTextStyle.sfProSemibold.copyWith(
            fontSize: 28,
            color: MyColors.c_0D0D26,
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            '-----------------------------------------------------------',
            style: MyTextStyle.sfProRegular.copyWith(
              fontSize: 15,
              color: MyColors.c_95969D,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
