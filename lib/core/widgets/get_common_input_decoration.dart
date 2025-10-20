import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_color.dart';
import '../theming/app_styles.dart';

InputDecoration getCommonInputDecoration({
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  TextStyle? labelStyle,
  Color? fillColor,
  double? verticalPadding,
}) {
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: fillColor ?? AppColors.whiteColor,
    contentPadding: EdgeInsets.symmetric(
      vertical: verticalPadding ?? 15.h,
      horizontal: 20.w,
    ),
    focusColor: AppColors.lightGrayColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightGrayColor, width: 1.3),
      borderRadius: BorderRadius.circular(16.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightGrayColor, width: 1.3),
      borderRadius: BorderRadius.circular(16.r),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.3),
      borderRadius: BorderRadius.circular(16.r),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 1.3),
      borderRadius: BorderRadius.circular(16.r),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lightGrayColor, width: 1.3),
      borderRadius: BorderRadius.circular(16.r),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lightGrayColor, width: 1.3),
      borderRadius: BorderRadius.circular(16.r),
    ),
    hintText: hintText,
    hintStyle: labelStyle ?? AppStyles.font15GrayRegular,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );
}