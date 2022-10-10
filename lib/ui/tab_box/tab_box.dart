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
        data:
            const NavigationBarThemeData(indicatorColor: MyColors.primaryColor),
        child: NavigationBar(
          backgroundColor: CupertinoColors.quaternarySystemFill,
          elevation: 0,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: context.watch<TabCubit>().tabIndex,
          onDestinationSelected: (v) {
            context.read<TabCubit>().changeTabState(v);
          },
          destinations:  [
            NavigationDestination(
              icon: Image.asset(MyIcons.announcement,height: 25,),
              label: '',
              selectedIcon: Image.asset(MyIcons.announcement,height: 25,color: Colors.white,),
            ),
            NavigationDestination(
              icon: Image.asset(MyIcons.vacancies,height: 25,),
              label: '',
              selectedIcon: Image.asset(MyIcons.vacancies,height: 25,color: Colors.white,),
            ),
            NavigationDestination(
              icon: Image.asset(MyIcons.profile,height: 25,),
              label: '',
              selectedIcon: Image.asset(MyIcons.profile,height: 25,color: Colors.white,),
            ),
          ],
        ),
      ),

      //  BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: MyColors.textColor,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   iconSize: 24,
      //   onTap: (index) {
      //     setState(() {
      //       currentIndex = index;
      //     });
      //   },
      //   currentIndex: currentIndex,
      //   items: [
      //     getItem(icon: Icons.store, labelText: "Home"),
      //     getItem(icon: Icons.category, labelText: "Category"),
      //     getItem(icon: Icons.shopping_basket, labelText: "Card"),
      //   ],
      // ),
    );
  }

  BottomNavigationBarItem getItem(
      {required IconData icon, required String labelText}) {
    return BottomNavigationBarItem(
        label: labelText,
        icon: Icon(
          icon,
          color: MyColors.white,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.yellowAccent,
        ));
  }
}
