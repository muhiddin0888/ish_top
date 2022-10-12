import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ish_top/app/view/app.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';
import 'package:ish_top/ui/login/login.dart';
import 'package:ish_top/ui/on_boarding/on_boarding_page.dart';
import 'package:ish_top/ui/sign_up/sign_up.dart';
import 'package:ish_top/ui/splash/splash_page.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/add_announcement_page.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/select_address_with_map.dart';
import 'package:ish_top/ui/tab_box/announcements/detail_announcements_page.dart';
import 'package:ish_top/ui/tab_box/profile/view/profile_update_page.dart';
import 'package:ish_top/ui/tab_box/tab_box.dart';
import 'package:ish_top/utils/constants.dart';

class MyRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return navigateTo(const MainOnBoardingPage());
      case mainPage:
        return navigateTo(const MainPage());
      case tabBox:
        return navigateTo(const TabBox());
      case splashPage:
        return navigateTo(const SplashScreen());
      case loginPage:
        return navigateTo(const LoginPage());
      case signUpPage:
        return navigateTo(const SignUpPage());
      case addAnnouncementPage:
        return navigateTo(const AddAnnouncementPage());
      case profileUpdatePage:
        return navigateTo(const ProfileUpdatePage());
      case googleMapView:
        return navigateTo(const GoogleMapView());
      case detailAnnouncements:
        final args = settings.arguments as List;
        return navigateTo(
          DetailAnnouncementsPage(
            announcementModel: args[0],
            helperRepository:
                HelperRepository(fireStore: FirebaseFirestore.instance),
            users: args[1],
          ),
        );
      default:
        return navigateTo(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

MaterialPageRoute navigateTo(Widget widget) => MaterialPageRoute(
      builder: (context) => widget,
    );
