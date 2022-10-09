import 'package:flutter/material.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/ann_fields_four.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/ann_fields_one.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/ann_fields_three.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/ann_fields_two.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/widgets/top_leader_view.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/custom_app_bar.dart';
import 'package:ish_top/utils/color.dart';


class AddAnnouncementPage extends StatefulWidget {
  const AddAnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AddAnnouncementPage> createState() => _AddAnnouncementPageState();
}

class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: CustomAppBar(

        onBackTap: () {
          if (currentPage >= 0) {
            setState(() {
              --currentPage;
            });
            pageController.animateToPage(currentPage,
                duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
          } else {
            Navigator.pop(context);
          }
        },

      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TopLeaderView(currentPage: currentPage + 1), // 1, 2, 3, 4
            Expanded(
                child: PageView(
              controller: pageController,
              onPageChanged: (pageNumber) {
                setState(() {
                  currentPage = pageNumber;
                });
              },
              children: const [
                AnnFieldsOne(),
                AnnFieldsTwo(),
                AnnFieldsThree(),
                AnnFieldsFour(),
              ],
            )),
            ActiveButton(buttonText: "Next", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
