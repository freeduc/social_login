import 'package:flutter/material.dart';
import 'package:social_login/resources/strings.dart';

class FilledRectangleButton extends StatelessWidget {
  const FilledRectangleButton({
    Key? key,
    required this.child,
    this.disabled = false,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final bool disabled;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: TextButton.styleFrom(
        backgroundColor: disabled ? Colors.grey : Strings.appPrimaryColor,
        shape: const BeveledRectangleBorder(),
        primary: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
