import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/utils/icon.dart';

const _avatarSize = 50.0;

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({super.key, required this.photo});

  final String photo;

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        BlocProvider.of<UserCubit>(context).state.userModel.imageUrl;
    debugPrint("imageUrl>>>>>>>>>>>>>>  $imageUrl");
    return CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      radius: _avatarSize,
      child: imageUrl.isEmpty
          ? Image.asset(MyIcons.defaultUser)
          : Image.network(imageUrl),
    );
  }
}
