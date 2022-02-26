import 'package:exercise_flutter/src/constants/asset_constant.dart';
import 'package:exercise_flutter/src/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenBloc {
  final List<String> languageIcons = [
    AssetConstant.flag_uk,
    AssetConstant.flag_cambodia,
    AssetConstant.flag_japan,
    AssetConstant.flag_china,
  ];

  void pushToMainScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }
}
