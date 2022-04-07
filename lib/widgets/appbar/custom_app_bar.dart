import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    required BuildContext context,
    bool useDrawer = false,
    bool usePop = true,
  }) : super(
          key: key,
          centerTitle: true,
          title: SvgPicture.asset('assets/images/logo/logo.svg'),
          leading: usePop
              ? TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset('assets/images/icon/chevron_left.svg'),
                )
              : Container(),
          actions: useDrawer
              ? [
                  Builder(
                    builder: (context) => TextButton(
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      child: SvgPicture.asset('assets/images/icon/hamburger_menu.svg'),
                    ),
                  ),
                ]
              : null,
        );
}
