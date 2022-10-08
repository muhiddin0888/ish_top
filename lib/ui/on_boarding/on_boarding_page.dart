import 'package:flutter/material.dart';
import 'package:ish_top/utils/icon.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example"),),
      body: Center(
        child: Image.asset(MyIcons.boardingImage5)
      ),
    );
  }
}
