import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_color.dart';

class AppCustomBackButton extends StatelessWidget {
  const AppCustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColors.lighterGreenColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          // هنا اللي بيخلي الأيقونة في النص دايمًا
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.primaryColor,
            size: 22.r,
          ),
        ),
      ),
    );
  }
}