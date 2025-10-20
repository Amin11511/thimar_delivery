import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_color.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';

class RegisterStepsWidget extends StatelessWidget {
  final int currentPage;

  const RegisterStepsWidget({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text("1", style: AppStyles.font16WhiteBold),
                ),
              ),
              verticalSpace(8),
              Text(
                "البيانات الشخصية",
                style: AppStyles.font14greenBold,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: DottedLine(
              dashLength: 6,
              dashGapLength: 4,
              lineThickness: 2,
              dashColor:currentPage==1?AppColors.primaryColor: AppColors.grayColor.withOpacity(0.4),
            ),
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: currentPage == 1
                    ? AppColors.primaryColor
                    : AppColors.lighterGreenColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  "2",
                  style: AppStyles.font16WhiteBold.copyWith(
                    color: currentPage == 1
                        ? Colors.white
                        : AppColors.grayColor,
                  ),
                ),
              ),
            ),
            verticalSpace(8),
            Text(
              "بيانات السيارة",
              style: AppStyles.font14WhiteBold.copyWith(
                color: currentPage == 1
                    ? AppColors.primaryColor
                    : AppColors.grayColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}