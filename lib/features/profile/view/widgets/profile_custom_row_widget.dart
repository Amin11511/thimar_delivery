import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_assets.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/utils/spacing.dart';

class ProfileCustomRowWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isHasIcon;
  final String? changeArrow;

  const ProfileCustomRowWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.isHasIcon = true,
    this.changeArrow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isHasIcon == false
                ? SizedBox.shrink()
                : Image.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
            ),
            horizontalSpace(12),
            Center(
              child: Text(
                title,
                style: AppStyles.font16GreenBold,
              ),
            ),
            Spacer(),
            Image.asset(
              changeArrow ?? AppAssets.arrowLeftImage,
              width: 24.w,
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}