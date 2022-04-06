import 'package:flutter/material.dart';

class CustomButtonTheme extends ButtonThemeData {
  CustomButtonTheme() {
    themeData = ButtonThemeData(
      highlightColor: Colors.transparent,
      buttonColor: Colors.black,
    );
  }

  late ButtonThemeData themeData;
}
