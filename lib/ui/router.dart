import 'package:flutter/material.dart';
import 'package:ish_top/app/view/app.dart';
import 'package:ish_top/ui/login/login.dart';
import 'package:ish_top/ui/on_boarding/on_boarding_page.dart';
import 'package:ish_top/ui/sign_up/sign_up.dart';
import 'package:ish_top/ui/splash/splash_page.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/add_announcement_page.dart';
import 'package:ish_top/ui/tab_box/profile/view/profile_update_page.dart';
import 'package:ish_top/ui/tab_box/tab_box.dart';
import 'package:ish_top/utils/constants.dart';

class MyRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return MaterialPageRoute(
          builder: (_) => MainOnBoardingPage(),
        );
      case mainPage:
        return navigateTo(MainPage());
      case tabBox:
        return navigateTo(TabBox());
      case splashPage:
        return navigateTo(SplashScreen());
      case loginPage:
        return navigateTo(LoginPage());
      case signUpPage:
        return navigateTo(SignUpPage());
      case addAnnouncementPage:
        return navigateTo(AddAnnouncementPage());
      case profileUpdatePage:
        return navigateTo(ProfileUpdatePage());
      default:
        return navigateTo(Scaffold(
          body: Center(
              child: Text('No route defined for ${settings.name}')),
        ));
    }
  }
}
MaterialPageRoute navigateTo(Widget widget) => MaterialPageRoute(builder: (context) => widget,);
