import 'package:flutter/material.dart';
import 'package:ish_top/app/view/app.dart';
import 'package:ish_top/ui/home/home.dart';
import 'package:ish_top/ui/login/login.dart';
import 'package:ish_top/ui/sign_up/sign_up.dart';
import 'package:ish_top/ui/splash/splash_page.dart';
import 'package:ish_top/utils/constants.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUpPage:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
