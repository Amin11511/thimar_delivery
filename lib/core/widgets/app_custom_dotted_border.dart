import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_color.dart';
import '../theming/app_styles.dart';

class AppCustomDottedBorder extends StatelessWidget {
  final String title;

  const AppCustomDottedBorder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1.w,
      borderType: BorderType.RRect,
      radius: Radius.circular(16.r),
      dashPattern: const [6, 4],
      child: Container(
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.lighterGreenColor,
        ),
        child: Center(child: Text(title, style: AppStyles.font16GreenBold)),
      ),
    );
  }
}