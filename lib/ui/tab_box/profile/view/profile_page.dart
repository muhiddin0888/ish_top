import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/ui/tab_box/profile/widgets/alert_dialog.dart';
import 'package:ish_top/ui/tab_box/profile/widgets/profile_item.dart';
import 'package:ish_top/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ProfilePage());

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isActive = false;
  int selectedIndex = -1;

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).fetchUser(
      BlocProvider.of<AppBloc>(context).state.user.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      context
                          .watch<UserCubit>()
                          .state
                          .userModel
                          .imageUrl
                          .toString(),
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Text(
                    user.email!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: height * .02),
                  ProfileItem(
                      width,
                      height,
                      state,
                      Text(
                        state.userModel.fullName.toString() == ''
                            ? 'Your full name'
                            : state.userModel.fullName.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      () {}),
                  ProfileItem(
                      width,
                      height,
                      state,
                      Text(
                        state.userModel.fullName.toString() == ''
                            ? 'Your phone number'
                            : state.userModel.phoneNumber.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      () {}),
                  ProfileItem(
                    width,
                    height,
                    state,
                    Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    () {
                      Navigator.pushNamed(context, profileUpdatePage);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextButton alertTextButton({
    required Color bgColor,
    required Color textColor,
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 10,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          bgColor,
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
