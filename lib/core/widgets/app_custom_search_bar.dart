import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_assets.dart';
import '../theming/app_color.dart';
import 'app_text_form_field.dart';

class AppCustomSearchBar extends StatelessWidget {
  final String? hintText;
  final Function(String)? validator;
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? enabled;
  final bool? readOnly;
  final VoidCallback? onTap;

  const AppCustomSearchBar({
    super.key,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.fillColor,
    this.controller,
    this.onChanged,
    this.enabled,
    this.readOnly,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      hintText: hintText ?? "ابحث عن ماتريد؟",
      validator: validator ?? (value) {},
      // prefixIcon: Image.asset(
      //   AppAssets.searchIconSvg,
      //   width: 25.w,
      //   height: 25.h,
      // ),
      suffixIcon: suffixIcon,
      fillColor: AppColors.fillGrayColor,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}