import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.primary,
    this.backgroundColor,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget child;
  final Color? primary;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: TextButton.styleFrom(
        minimumSize: const Size(90, 0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        primary: primary ?? const Color(0xFF333333),
        backgroundColor: backgroundColor ?? const Color(0xFFEFEFEF),
      ),
    );
  }
}
