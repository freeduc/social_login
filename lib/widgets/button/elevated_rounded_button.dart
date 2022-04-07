import 'package:flutter/material.dart';

class ElevatedRoundedButton extends StatelessWidget {
  const ElevatedRoundedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.borderColor,
    this.shadowColor,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? const Color(0x0D000000),
            blurRadius: 3.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: child,
        style: TextButton.styleFrom(
          primary: Color(0xFF333333),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          side: BorderSide(color: borderColor ?? const Color(0xFFE4E4E4)),
        ),
      ),
    );
  }
}
