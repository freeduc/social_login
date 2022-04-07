import 'package:flutter/material.dart';

class CustomBodyContainer extends StatelessWidget {
  const CustomBodyContainer({
    Key? key,
    required this.child,
    this.isPaddingTop = false,
    this.isPaddingBottom = false,
    this.isScroll = false,
  }) : super(key: key);

  final Widget child;
  final bool isPaddingTop;
  final bool isPaddingBottom;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    Widget body = Container(
      padding: EdgeInsets.only(
        left: 20.0,
        top: isPaddingTop ? 20.0 : 0,
        right: 20.0,
        bottom: isPaddingBottom ? 20.0 : 0,
      ),
      child: child,
    );

    return isScroll
        ? SingleChildScrollView(
            child: body,
            physics: const BouncingScrollPhysics(),
          )
        : body;
  }
}
