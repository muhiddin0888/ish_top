import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/app/bloc/app_bloc.dart';
import 'package:ish_top/ui/widgets/white_flat_appbar.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/constants.dart';
import 'package:ish_top/utils/icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _init() async {
    String userId = BlocProvider.of<AppBloc>(context).state.user.id;
    Future.delayed(const Duration(seconds: 2), () {
      if (userId == '') {
        Navigator.pushReplacementNamed(context, onBoarding);
      } else {
        Navigator.pushReplacementNamed(context, mainPage);
      }
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: const WhiteFlatAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(MyIcons.findJob),
        ],
      ),
    );
  }
}
