import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({Key? key, this.onBackTap, this.title}) : super(key: key);

  final VoidCallback? onBackTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.white,
      elevation: 0,
      title: Text(title ?? "",
          style: MyTextStyle.sfBold800.copyWith(fontSize: 20)),
      leading: onBackTap != null
          ? IconButton(
              onPressed: onBackTap,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )
          : null,
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
