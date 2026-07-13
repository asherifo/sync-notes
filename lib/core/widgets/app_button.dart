import 'package:flutter/material.dart';

import '../utils/txt_style.dart';

class AppButton extends StatelessWidget {
  double buttonWidth;
  String txt;
  VoidCallback  onPress;

  AppButton({super.key, required this.buttonWidth, required this.txt, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: buttonWidth,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text(txt, style: TxtStyle.primaryStyle)),
      ),
    );
  }
}