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
import 'package:ish_top/ui/tab_box/announcements/detail_announcement_page/detail_announcements_page.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_one/select_address_with_map.dart';
import 'package:ish_top/ui/tab_box/notification_page/notification_page.dart';
import 'package:ish_top/ui/tab_box/profile/view/profile_update_page.dart';
import 'package:ish_top/ui/tab_box/tab_box.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/add_vacancy/add_vacancy_page.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/vacancy_detail/vacancy_detail_page.dart';
import 'package:ish_top/utils/constants.dart';

class MyRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return navigateTo( MainOnBoardingPage());
      case mainPage:
        return navigateTo( MainPage());
      case tabBox:
        return navigateTo( TabBox());
      case splashPage:
        return navigateTo( SplashScreen());
      case loginPage:
        return navigateTo( LoginPage());
      case signUpPage:
        return navigateTo( SignUpPage());
      case addAnnouncementPage:
        return navigateTo( AddAnnouncementPage());
      case addVacancyPage:
        return navigateTo( AddVacancyPage());
      case profileUpdatePage:
        return navigateTo( ProfileUpdatePage());
      case notificationPage:
        return navigateTo( NotificationPage());
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
      case googleMapView:
        return navigateTo(
          GoogleMapView(
            addressName: settings.arguments as ValueChanged<String>,
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
