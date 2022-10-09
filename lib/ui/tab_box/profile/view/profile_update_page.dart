import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/data/models/users/user_model.dart';
import 'package:ish_top/ui/widgets/active_button.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Update page"),
      ),
      body: Column(
        children: [


          ActiveButton(
              buttonText: "Update",
              onPressed: () {
                var currentUser =
                    BlocProvider.of<UserCubit>(context).state.userModel;

                UserModel userModel = UserModel(
                  imageUrl: "",
                  createdAt: currentUser.createdAt,
                  fullName: "",
                  phoneNumber: "",
                  userId: currentUser.userId,
                );

                BlocProvider.of<UserCubit>(context).updateUser(userModel);

              }),
        ],
      ),
    );
  }
}
