import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ish_top/utils/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({Key? key, this.onBackTap}) : super(key: key);

  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.white,
      elevation: 0,
      // TODO: bir hil joylarda arrow kerakmas shunga onBackTap null bolishi ham mumkin (sherzod)
      leading: onBackTap != null ? IconButton(
        onPressed: onBackTap,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ):null,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: MyColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget get child => throw UnimplementedError();
}
