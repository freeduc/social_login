import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({
    Key? key,
    required this.child,
    this.isPaddingTop = true,
    this.isPaddingBottom = true,
    this.isScroll = false,
  }) : super(key: key);

  final Widget child;
  final bool isPaddingTop;
  final bool isPaddingBottom;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: isPaddingTop,
      bottom: isPaddingBottom,
      child: Container(
        color: Colors.white,
        child: isScroll
            ? SingleChildScrollView(
                child: child,
              )
            : child,
      ),
    );
  }
}
