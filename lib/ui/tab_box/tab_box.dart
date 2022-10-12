import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/tab/tab_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/announcements_page.dart';
import 'package:ish_top/ui/tab_box/profile/home.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/vacancies_page.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  List<Widget> screens = [
    AnnouncementsPage(),
    VacanciesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocBuilder<TabCubit, TabState>(
        builder: (cubit, state) {
          if (state is TabHome) {
            return const AnnouncementsPage();
          } else if (state is TabCategory) {
            return const VacanciesPage();
          } else if (state is TabCard) {
            return const ProfilePage();
          } else {
            return const Center(
              child: Text(
                'Not Found',
              ),
            );
          }
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(indicatorColor: MyColors.primaryColor),
        child: NavigationBar(
          backgroundColor: CupertinoColors.quaternarySystemFill,
          elevation: 0,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: context.watch<TabCubit>().tabIndex,
          onDestinationSelected: (v) {
            context.read<TabCubit>().changeTabState(v);
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.store_mall_directory_outlined),
              label: '',
              selectedIcon: Icon(Icons.store),
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              label: '',
              selectedIcon: Icon(Icons.category),
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_basket_outlined),
              label: '',
              selectedIcon: Icon(Icons.shopping_basket),
            ),
          ],
        ),
      ),
    );
  }
}
