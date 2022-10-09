import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ish_top/ui/on_boarding/pages/fifth_on_boarding_page.dart';
import 'package:ish_top/ui/on_boarding/pages/first_on_boarding_page.dart';
import 'package:ish_top/ui/on_boarding/pages/fourth_on_boarding_page.dart';
import 'package:ish_top/ui/on_boarding/pages/second_on_boarding_page.dart';
import 'package:ish_top/ui/on_boarding/pages/sixth_on_boarding_page.dart';
import 'package:ish_top/ui/on_boarding/pages/third_on_boarding_page.dart';
import 'package:ish_top/ui/on_boarding/widgets/half_circle_on_top.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainOnBoardingPage extends StatelessWidget {
  const MainOnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentPage = 0;
    PageController pageController = PageController();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.C_CFD5DE,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: MyColors.C_FAFAFD,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              CustomPaint(
                size: Size(
                    double.infinity, MediaQuery.of(context).size.height * 0.14),
                painter: HalfCirleOnTopPaint(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: const [
                    FirstOnBoardingPage(),
                    SecondOnBoardingPage(),
                    ThirdOnBoardingPage(),
                    FourthOnBoardingPage(),
                    FifthOnBoardingPage(),
                    SixthOnBoardingPage()
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              SmoothPageIndicator(
                controller: pageController,
                count: 6,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: MyColors.C_2C557D,
                  dotColor: MyColors.C_E4E5E7,
                ),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, mainPage);
                        },
                        child:  Text(
                          "Skip",
                          style: TextStyle(
                            color: MyColors.C_95969D,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    ActiveButton(
                      width: 158,
                      buttonText: "Next",
                      onPressed: () {
                        currentPage++;
                        if (currentPage == 6) {
                          Navigator.pushReplacementNamed(context, mainPage);
                        } else {
                          pageController.animateToPage(
                            currentPage,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
