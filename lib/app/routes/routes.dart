import 'package:flutter/widgets.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/login/login.dart';
import 'package:ish_top/ui/home/view/home_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
