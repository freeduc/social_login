
import 'package:flutter/material.dart';
import 'package:social_login/resources/strings.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.style,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final void Function() onPressed;
  final Color? backgroundColor;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: child,
      style: style ??
          OutlinedButton.styleFrom(
            backgroundColor: backgroundColor ?? Strings.appPrimaryColor,
            primary: Colors.white,
          ),
    );
  }
}
