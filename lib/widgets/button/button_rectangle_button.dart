
import 'package:flutter/material.dart';
import 'package:social_login/widgets/button/filled_rectangle_button.dart';

class BottomRectangleButton extends StatelessWidget {
  const BottomRectangleButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.disabled = false,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: FilledRectangleButton(
        onPressed: onPressed,
        disabled: disabled,
        child: Text(text),
      ),
    );
  }
}
