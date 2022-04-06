import 'package:flutter/material.dart';
import 'package:social_login/widgets/drawer/custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    required this.body,
    this.appbar,
    this.backgroundColor,
    this.useDrawer = false,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget? appbar;
  final bool useDrawer;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      backgroundColor: backgroundColor,
      endDrawer: useDrawer ? const CustomDrawer() : null,
    );
  }
}
