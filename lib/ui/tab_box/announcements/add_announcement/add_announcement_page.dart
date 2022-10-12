// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ish_top/app/app.dart';
// import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
// import 'package:ish_top/cubits/cv_url/cv_url_cubit.dart';
// import 'package:ish_top/data/repositories/helper/helper_repository.dart';
// import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_four/ann_fields_four.dart';
// import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_one/ann_fields_one.dart';
// import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_two/ann_fields_two.dart';
// import 'package:ish_top/ui/tab_box/announcements/add_announcement/widgets/top_leader_view.dart';
// import 'package:ish_top/ui/widgets/active_button.dart';
// import 'package:ish_top/ui/widgets/custom_app_bar.dart';
// import 'package:ish_top/utils/color.dart';
// import 'pages/add_fields_three/ann_fields_three.dart';

// class AddAnnouncementPage extends StatefulWidget {
//   const AddAnnouncementPage({Key? key}) : super(key: key);

//   @override
//   State<AddAnnouncementPage> createState() => _AddAnnouncementPageState();
// }

// class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
//   final PageController pageController = PageController();
//   int currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CvUrlCubit(
//         helperRepository: context.read<HelperRepository>(),
//       ),
//       child: Scaffold(
//         backgroundColor: MyColors.backgroundColor,
//         appBar: CustomAppBar(
//           onBackTap: () {
//             if (currentPage >= 1) {
//               setState(() {
//                 --currentPage;
//               });
//               navigateToPage();
//             } else {
//               Navigator.pop(context);
//             }
//           },
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 2.0, bottom: 8.0, top: 8.0),
//           child: Column(
//             children: [
//               TopLeaderView(currentPage: currentPage + 1), // 1, 2, 3, 4
//               Expanded(
//                   child: PageView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 controller: pageController,
//                 onPageChanged: (pageNumber) {
//                   setState(() {
//                     currentPage = pageNumber;
//                   });
//                 },
//                 children: [
//                   AnnFieldsOne(),
//                   AnnFieldsTwo(),
//                   AnnFieldsThree(),
//                   AnnFieldsFour(),
//                 ],
//               )),
//               //0,1,2,3
//               Builder(builder: (context) {
//                 return BlocBuilder<CvUrlCubit, CvUrlState>(
//                   builder: (context, state) {
//                     return ActiveButton(
//                         buttonText: "Next",
//                         onPressed: () {
//                           if (currentPage == 3) {
//                             BlocProvider.of<AnnouncementCubit>(context)
//                                 .updateCurrentItem(
//                               fieldValue: BlocProvider.of<AppBloc>(context)
//                                   .state
//                                   .user
//                                   .id,
//                               fieldKey: "user_id",
//                             );
//                             BlocProvider.of<AnnouncementCubit>(context)
//                                 .updateCurrentItem(
//                                     fieldValue: BlocProvider.of<CvUrlCubit>(context,
//                                     listen: false)
//                                 .state
//                                 .cvUrl
//                                 .downloadUrl,
//                                     fieldKey: "cv_url");
//                             BlocProvider.of<AnnouncementCubit>(context)
//                                 .addAnnouncement();
//                           }
//                           if ((currentPage < 3)) {
//                             setState(() {
//                               currentPage++;
//                               print(currentPage);
//                             });
//                             navigateToPage();
//                           }
//                         });
//                   },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void navigateToPage() {
//     pageController.animateToPage(currentPage,
//         duration: Duration(milliseconds: 500), curve: Curves.linear);
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/widgets/top_leader_view.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/custom_app_bar.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/my_utils.dart';

import 'pages/add_fields_four/ann_fields_four.dart';
import 'pages/add_fields_one/ann_fields_one.dart';
import 'pages/add_fields_three/ann_fields_three.dart';
import 'pages/add_fields_two/ann_fields_two.dart';

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
            TopLeaderView(currentPage: currentPage + 1), // 1, 2, 3, 4
            Expanded(
                child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (pageNumber) {
                setState(() {
                  currentPage = pageNumber;
                });
              },
              children: [
                AnnFieldsOne(),
                AnnFieldsTwo(),
                AnnFieldsThree(),
                AnnFieldsFour(),
              ],
            )),
            //0,1,2,3
            ActiveButton(
                buttonText: "Next",
                onPressed: () {
                  var t = BlocProvider.of<AnnouncementCubit>(context);
                  if (currentPage == 3) {
                   if(isPageFourValidated(t.state.fields)){
                     BlocProvider.of<AnnouncementCubit>(context)
                         .addAnnouncement();
                     BlocProvider.of<AnnouncementCubit>(context)
                         .updateCurrentItem(
                       fieldValue:
                       BlocProvider.of<AppBloc>(context).state.user.id,
                       fieldKey: "user_id",
                     );
                   }
                  }
                  if ((currentPage < 3)) {
                    switch (currentPage) {
                      case 0:
                        {
                          if (isPageOneValidated(t.state.fields)) {
                            setState(() {
                              currentPage++;
                            });
                            navigateToPage();
                          }
                        }
                        break;
                      case 1:
                        {
                          if (isPageTwoValidated(t.state.fields)) {
                            setState(() {
                              currentPage++;
                            });
                            navigateToPage();
                          }
                        }
                        break;
                      case 2:
                        {
                          if (isPageThreeValidated(t.state.fields)) {
                            setState(() {
                              currentPage++;
                            });
                            navigateToPage();
                          }
                        }
                        break;
                      default:{}
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  void navigateToPage() {
    pageController.animateToPage(currentPage,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  bool isPageOneValidated(Map<String, dynamic> fields) {
    bool isValid = false;
    String fullName = fields["full_name"];
    int age = fields["age"];
    String phoneNumber = fields["phone_number"];
    String address = fields["address"];
    if (fullName.length < 3) {
      MyUtils.getMyToast(message: "To'liq ism sharifingizni kiriting!");
    } else if (age <= 12) {
      MyUtils.getMyToast(message: "11 dan katta yosh kiriting!");
    } else if (phoneNumber.length < 10) {
      MyUtils.getMyToast(message: "Telefon raqamni to'gri kiriting");
    } else if (address.length < 10) {
      MyUtils.getMyToast(message: "Manzilni to'gri kiriting");
    } else {
      isValid = true;
    }
    return isValid;
  }
  bool isPageTwoValidated(Map<String, dynamic> fields) {
    bool isValid = false;
    String fullName = fields["full_name"];
    int age = fields["age"];
    String phoneNumber = fields["phone_number"];
    String address = fields["address"];
    if (fullName.length < 3) {
      MyUtils.getMyToast(message: "To'liq ism sharifingizni kiriting!");
    } else if (age <= 12) {
      MyUtils.getMyToast(message: "11 dan katta yosh kiriting!");
    } else if (phoneNumber.length < 10) {
      MyUtils.getMyToast(message: "Telefon raqamni to'gri kiriting");
    } else if (address.length < 10) {
      MyUtils.getMyToast(message: "Manzilni to'gri kiriting");
    } else {
      isValid = true;
    }
    return isValid;
  }
  bool isPageThreeValidated(Map<String, dynamic> fields) {
    bool isValid = false;
    String fullName = fields["full_name"];
    int age = fields["age"];
    String phoneNumber = fields["phone_number"];
    String address = fields["address"];
    if (fullName.length < 3) {
      MyUtils.getMyToast(message: "To'liq ism sharifingizni kiriting!");
    } else if (age <= 12) {
      MyUtils.getMyToast(message: "11 dan katta yosh kiriting!");
    } else if (phoneNumber.length < 10) {
      MyUtils.getMyToast(message: "Telefon raqamni to'gri kiriting");
    } else if (address.length < 10) {
      MyUtils.getMyToast(message: "Manzilni to'gri kiriting");
    } else {
      isValid = true;
    }
    return isValid;
  }
  bool isPageFourValidated(Map<String, dynamic> fields) {
    bool isValid = false;
    String fullName = fields["full_name"];
    int age = fields["age"];
    String phoneNumber = fields["phone_number"];
    String address = fields["address"];
    if (fullName.length < 3) {
      MyUtils.getMyToast(message: "To'liq ism sharifingizni kiriting!");
    } else if (age <= 12) {
      MyUtils.getMyToast(message: "11 dan katta yosh kiriting!");
    } else if (phoneNumber.length < 10) {
      MyUtils.getMyToast(message: "Telefon raqamni to'gri kiriting");
    } else if (address.length < 10) {
      MyUtils.getMyToast(message: "Manzilni to'gri kiriting");
    } else {
      isValid = true;
    }
    return isValid;
  }
}
