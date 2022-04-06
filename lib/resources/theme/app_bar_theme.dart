import 'package:flutter/material.dart';

class CustomAppBarTheme {
  CustomAppBarTheme() {
    appBarTheme = const AppBarTheme(
      backgroundColor: Colors.white,
      shadowColor: Color(0x5F000000),
      toolbarHeight: 60.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    );
  }

  late AppBarTheme appBarTheme;
}
