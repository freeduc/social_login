import 'package:flutter/material.dart';

import '../function.dart';
import '../strings.dart';
import 'app_bar_theme.dart';
import 'app_button_theme.dart';
import 'app_text_theme.dart';

class CustomAppThemeData {
  CustomAppThemeData(BuildContext context) {
    themeData = ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Functions.createMaterialColor(const Color(0xff1F59BE)),
        fontFamily: Strings.korFont,
        buttonTheme: CustomButtonTheme().themeData,
        appBarTheme: CustomAppBarTheme().appBarTheme,
        primaryTextTheme: CustomTextTheme(context: context).textTheme);
  }

  late ThemeData themeData;
}
