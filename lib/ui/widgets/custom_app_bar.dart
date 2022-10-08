import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ish_top/utils/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({Key? key, required this.onBackTap}) : super(key: key);

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.textColor,
      elevation: 0,
      leading: IconButton(onPressed: onBackTap, icon: Icon(Icons.arrow_back),),
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
