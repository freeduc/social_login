import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

abstract class Functions {
  // swatch color generator
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  // 기준 앱 사이즈
  static double standardWidth = 0;
  static double standardHeight = 0;

  // 디바이스 앱 사이즈 계산
  static void calcPlatformSize(BuildContext context) {
    const double XDWidth = 375;
    const double XDHeight = 667;

    standardWidth = MediaQuery.of(context).size.width / XDWidth;
    standardHeight = MediaQuery.of(context).size.height / XDHeight;
  }

  // 디바이스 앱 사이즈 조회
  static double getWidth(double width) => standardWidth * width;
  static double getHeight(double height) => standardHeight * height;

  /// utf8 지원 제이슨 디코더
  static Map<String, dynamic> toJsonUTF8(Uint8List byteList) =>
      jsonDecode(utf8.decode(byteList));
}
