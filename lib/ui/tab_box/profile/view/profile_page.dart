import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/ui/tab_box/profile/widgets/profile_image_shimmer.dart';
import 'package:ish_top/ui/tab_box/profile/widgets/profile_item.dart';
import 'package:ish_top/utils/constants.dart';
import 'package:ish_top/utils/icon.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ProfilePage());

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isActive = false;
  int selectedIndex = -1;
  String networkImage = 'rasm yoq';

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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  content: const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "Are you sure want to logout?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  actions: [
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          alertTextButton(
                            textColor: Colors.blue,
                            bgColor: Colors.grey.shade100,
                            text: "Yes\t😔",
                            onPressed: () {
                              // context.read<AppBloc>().add(AppLogoutRequested());
                            },
                          ),
                          alertTextButton(
                            bgColor: Colors.blue,
                            textColor: Colors.white,
                            text: "No\t😊",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              //
            },
          )
        ],
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          networkImage =
              context.read<UserCubit>().state.userModel.imageUrl.toString();
        },
        builder: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
            return const Center(child: ProfileImageShimmer());
          }
          networkImage = context.watch<UserCubit>().state.userModel.imageUrl;
          debugPrint("rasm>>>>>>>>>>>>> $networkImage");
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(
                  child: networkImage.isEmpty
                      ? Image.asset(
                          MyIcons.defaultUser,
                          scale: 5.5,
                        )
                      : Image.network(
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: height * .02),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileItem(
                        width,
                        height,
                        state,
                        Text(
                          state.userModel.fullName.toString() == ''
                              ? 'Your full name'
                              : state.userModel.fullName.toString(),
                          style: const TextStyle(
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
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        () {}),
                  ],
                ),
                const Expanded(child: SizedBox()),
                ProfileItem(
                  width,
                  height,
                  state,
                  const Text(
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
