import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/app/bloc/app_bloc.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/widgets/drawer_item.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/passive_button.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/constants.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:ish_top/utils/my_utils.dart';
import 'package:ish_top/utils/style.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Drawer(
          child: Column(
            children: [
              // DRAWER HEADER / USER INFO
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    // USER PICTURE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 85,
                        width: 85,
                        child: state.userModel.imageUrl.isEmpty
                            ? Image.asset(
                                MyIcons.userImg[3],
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                state.userModel.imageUrl,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // USER NAME
                    Text(
                      state.userModel.fullName,
                      style: MyTextStyle.sfProSemibold.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),

                    // USER EMAIL
                    Text(
                      user.email ?? '@email',
                      style: MyTextStyle.sfProSemibold,
                    ),

                    // NAVIGATO BUTTON TO EDIT PROFILE
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, profileUpdatePage);
                      },
                      child: Text(
                        'Edit Profile',
                        style: MyTextStyle.sfProMedium
                            .copyWith(fontSize: 16, color: MyColors.C_356899),
                      ),
                    ),
                  ],
                ),
              ),

              // DRAWER BODY
              const SizedBox(height: 30),
              CustomDrawerItem(
                title: 'Add',
                icon: CupertinoIcons.add,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('What do you want add?',
                                style: MyTextStyle.sfProRegular
                                    .copyWith(fontSize: 18)),
                            ActiveButton(
                              buttonText: 'Announcement',
                              onPressed: () {
                                Navigator.pop(_);
                                Navigator.pushNamed(_, addAnnouncementPage);
                              },
                            ),
                            PassiveButton(
                              buttonText: 'Vacancie',
                              onPressed: () {
                                Navigator.pop(_);
                                Navigator.pushNamed(_, addVacancyPage);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              CustomDrawerItem(
                title: 'Settings',
                icon: CupertinoIcons.settings,
                onPressed: () {
                  MyUtils.getMyToast(
                      message: 'Setting page qowilgandan keyin ishlaydi');
                },
              ),
              CustomDrawerItem(
                title: 'Notification',
                icon: Icons.notifications_none,
                onPressed: () {
                  MyUtils.getMyToast(
                      message: 'Notification page qowilgandan keyin ishlaydi');
                },
              ),
              CustomDrawerItem(
                title: 'About',
                icon: CupertinoIcons.info,
                onPressed: () {
                  MyUtils.getMyToast(
                      message: 'About page qowilgandan keyin ishlaydi');
                },
              ),
              CustomDrawerItem(
                title: 'Logout',
                icon: Icons.logout_outlined,
                itemColor: Colors.red,
                onPressed: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                },
              ),

              const Expanded(child: SizedBox()),
              // PREMIUM BUTTON
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: MediaQuery.of(context).padding.bottom),
                child: ActiveButton(
                  buttonText: 'Go Premium',
                  onPressed: () {
                    MyUtils.getMyToast(message: "versia 2.0 da qo'shiladi");
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
