import 'package:exercise_flutter/src/constants/asset_constant.dart';
import 'package:flutter/material.dart';

class AppIconWithText extends StatelessWidget {
  final double iconSize;
  final double textSize;

  const AppIconWithText({
    Key? key,
    this.iconSize = 64.0,
    this.textSize = 32.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Image.asset(
            AssetConstant.app_logo,
            height: iconSize,
            width: iconSize,
          ),
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        Text(
          'ចង់ញុាំ',
          style: TextStyle(color: Colors.white, fontSize: textSize),
        ),
      ],
    );
  }
}
