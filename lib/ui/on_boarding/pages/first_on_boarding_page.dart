import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:ish_top/utils/style.dart';

class FirstOnBoardingPage extends StatelessWidget {
  const FirstOnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            MyIcons.boardingImage1,
          ),
        ),
        Text(
          "Search your job",
          style: MyTextStyle.sfProSemibold.copyWith(
            fontSize: 28,
            color: MyColors.C_0D0D26,
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Figure out your top five priorities whether it is company culture, salary.',
            style: MyTextStyle.sfProRegular.copyWith(
              fontSize: 15,
              color: MyColors.C_95969D,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
