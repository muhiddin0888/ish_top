import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:ish_top/utils/style.dart';

class FifthOnBoardingPage extends StatelessWidget {
  const  FifthOnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            MyIcons.boardingImage5,
          ),
        ),
        Text(
          "Make your dream career with job",
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
