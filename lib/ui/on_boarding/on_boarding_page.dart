import 'package:flutter/material.dart';
import 'package:ish_top/ui/on_boarding/widgets/half_circle_on_top.dart';
import 'package:ish_top/utils/icon.dart';

class MainOnBoardingPage extends StatelessWidget {
  const MainOnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPaint(
                size: const Size(double.infinity, 300),
                painter: HalfCircleOnTopPaint(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
