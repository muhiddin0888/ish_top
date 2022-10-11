

import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';

class UrlContainer extends StatelessWidget {
  const UrlContainer({
    Key? key, required this.onTap, required this.title, required this.subTitle,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final String subTitle;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.C_F2F2F2,
        ),
        child: ListTile(
          leading: Image.asset(MyIcons.pdfImage),
          title:  Text(title),
          subtitle:  Text(subTitle),
          trailing: IconButton(onPressed: onTap,  icon: const Icon(Icons.cancel_outlined, color: Colors.red, size: 30,),),
        )
    );
  }
}