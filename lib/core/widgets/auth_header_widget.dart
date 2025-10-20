import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/app_assets.dart';
import '../theming/app_styles.dart';
import '../utils/spacing.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final bool? isHasButton;
  final String? buttonText;
  final VoidCallback? onPressed;
  final String? phoneNumber;

  const AuthHeaderWidget({
    super.key,
    this.title,
    this.subTitle,
    this.isHasButton,
    this.buttonText,
    this.onPressed,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(20),
        Center(
          child: Image.asset(
            AppAssets.thimarIcon,
            width: 150.w,
            height: 150.h,
          ),
        ),
        Text(
          title ?? "مرحبا بك مرة أخرى",
          style: AppStyles.font16GreenBold,
        ),
        verticalSpace(8),
        Text(
          subTitle ?? "يمكنك تسجيل الدخول الأن",
          style: AppStyles.font16DarkGrayLight,
        ),
        isHasButton == true
            ? Row(
          children: [
            Text(
              phoneNumber ?? "",
              style: AppStyles.font16DarkGrayLight,
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                "تغيير رقم الجوال",
                style: AppStyles.font16GreenBold.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )
            : verticalSpace(16),
        // verticalSpace(10),
      ],
    );
  }
}