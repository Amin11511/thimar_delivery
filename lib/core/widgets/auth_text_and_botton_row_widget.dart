import 'package:flutter/material.dart';
import '../../../core/theming/app_styles.dart';

class AuthTextAndButtonRowWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String buttonText;

  const AuthTextAndButtonRowWidget({
    super.key,
    this.onPressed,
    required this.text,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: AppStyles.font16greenLight),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: AppStyles.font16GreenBold,
          ),
        ),
      ],
    );
  }
}