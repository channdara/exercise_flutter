import 'package:exercise_flutter/src/blocs/splash_screen_bloc.dart';
import 'package:exercise_flutter/src/constants/asset_constant.dart';
import 'package:exercise_flutter/src/ui/widgets/app_icon_with_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenBloc _bloc = SplashScreenBloc();

  @override
  void initState() {
    _bloc.pushToMainScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AssetConstant.splash_background,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Align(
            alignment: Alignment.center,
            child: AppIconWithText(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Choose Language',
                    style: TextStyle(color: Colors.white),
                  ),
                  Wrap(
                    spacing: 16.0,
                    children: _bloc.languageIcons
                        .map((e) => Image.asset(e, height: 40.0))
                        .toList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
