import 'package:flutter/material.dart';

import '../strings.dart';

class CustomTextTheme {
  final BuildContext context;

  CustomTextTheme({required this.context}) {
    final subtitle1 = Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
          fontFamily: Strings.korFont,
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.4,
        );

    final subtitle2 = Theme.of(context).primaryTextTheme.subtitle2!.copyWith(
          fontFamily: Strings.korFont,
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.9,
        );

    final headline5 = Theme.of(context).primaryTextTheme.headline5!.copyWith(
          fontFamily: Strings.korFont,
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.25,
        );

    textTheme = Theme.of(context).primaryTextTheme.copyWith(
          subtitle1: subtitle1,
          subtitle2: subtitle2,
          headline5: headline5,
        );
  }

  late TextTheme textTheme;
}
