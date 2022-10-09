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
        return MaterialPageRoute(builder: (_) => MainPage());
      case tabBox:
        return MaterialPageRoute(builder: (_) => TabBox());
      case splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUpPage:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case addAnnouncementPage:
        return MaterialPageRoute(builder: (_) => AddAnnouncementPage());
      case profileUpdatePage:
        return MaterialPageRoute(builder: (_) => ProfileUpdatePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
