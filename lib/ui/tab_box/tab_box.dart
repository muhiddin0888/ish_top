import 'package:flutter/material.dart';
import 'package:ish_top/ui/tab_box/categories/categories_page.dart';
import 'package:ish_top/ui/tab_box/favourites/favourites_page.dart';
import 'package:ish_top/ui/tab_box/home/view/home_page.dart';
import 'package:ish_top/utils/color.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  List<Widget> screens = [
    HomePage(),
    CategoriesPage(),
    FavouritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:
          //screens[currentIndex],
          IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyColors.textColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 24,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: [
          getItem(icon: Icons.store, labelText: "Home"),
          getItem(icon: Icons.category, labelText: "Category"),
          getItem(icon: Icons.shopping_basket, labelText: "Card"),
        ],
      ),
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
