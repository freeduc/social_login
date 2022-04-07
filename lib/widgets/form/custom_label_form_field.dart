
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_login/resources/strings.dart';

class CustomLabelFormField extends StatelessWidget {
  const CustomLabelFormField({
    Key? key,
    this.controller,
    required this.label,
    this.digitOnly = false,
    this.button,
    this.hintText,
    this.maxLength,
    this.readOnly = false,
    this.isPassword = false,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final bool digitOnly;
  final Widget? button;
  final String? hintText;
  final int? maxLength;
  final void Function()? onTap;
  final bool readOnly;
  final bool isPassword;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.circle_outlined,
              color: Strings.appPrimaryColor,
              size: 10.0,
            ),
            const SizedBox(width: 5.0),
            Text(
              label,
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 45.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  inputFormatters: digitOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
                  maxLength: maxLength,
                  style: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: -0.8,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 13.0,
                      horizontal: 14.0,
                    ),
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFFB7B7B7),
                      fontSize: 16.0,
                      letterSpacing: -0.8,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFCCCCCC),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Strings.appPrimaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: onTap,
                  readOnly: readOnly,
                  onChanged: onChanged,
                  obscureText: isPassword,
                ),
              ),
              button ?? const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
