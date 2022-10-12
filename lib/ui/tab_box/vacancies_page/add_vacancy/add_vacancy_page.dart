import 'package:flutter/material.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/add_vacancy/pages/add_file_one/vac_fields_one.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/add_vacancy/pages/add_file_three/vac_fields_three.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/add_vacancy/pages/add_file_two/vac_fields_two.dart';
import 'package:ish_top/ui/widgets/custom_app_bar.dart';
import 'package:ish_top/utils/color.dart';

import 'widgets/top_leader_view_vacancy.dart';

class AddVacancyPage extends StatefulWidget {
  const AddVacancyPage({Key? key}) : super(key: key);

  @override
  State<AddVacancyPage> createState() => _AddVacancyPageState();
}

class _AddVacancyPageState extends State<AddVacancyPage> {

  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: CustomAppBar(
        onBackTap: () {
          if (currentPage >= 1) {
            setState(() {
              --currentPage;
            });
            navigateToPage();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 2.0, bottom: 8.0, top: 8.0),
        child: Column(
          children: [
            TopLeaderViewVacancy(currentPage: currentPage + 1),
            Expanded(
                child: PageView(
                  // physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (pageNumber) {
                    setState(() {
                      currentPage = pageNumber;
                    });
                  },
                  children: [
                    VacFieldsOne(),
                    VacFieldsTwo(),
                    VacFieldsThree()
                  ],
                )),
          ],
        ),
      ),
    );
  }
  void navigateToPage() {
    pageController.animateToPage(currentPage,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }
}

