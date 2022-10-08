import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ish_top/ui/on_boarding/pages/first_on_boarding_page.dart';
import 'package:ish_top/ui/on_boarding/widgets/half_circle_on_top.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:ish_top/utils/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainOnBoardingPage extends StatelessWidget {
  const MainOnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.c_CFD5DE,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: MyColors.c_FAFAFD,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPaint(
                size: Size(
                    double.infinity, MediaQuery.of(context).size.height * 0.14),
                painter: HalfCirleOnTopPaint(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const FirstOnBoardingPage(),
              ),
               
              SmoothPageIndicator(
                controller: pageController,
                count: 6,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: MyColors.c_2C557D,
                  dotColor: MyColors.c_E4E5E7,
                ),
              ),
         
            ],
          ),
        ),
      ),
    );
  }
}
