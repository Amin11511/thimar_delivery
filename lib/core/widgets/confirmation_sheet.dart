import 'package:thimar_driver/core/utils/extentions.dart';
import '../../generated/codegen_loader.g.dart';
import 'app_btn.dart';
import 'app_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationSheet extends StatelessWidget {
  final String title;
  final String? subTitle;
  const ConfirmationSheet({super.key, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      title: title,
      children: [
        Text(
          subTitle ?? '',
          style: context.regularText.copyWith(fontSize: 14, color: context.hintColor),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: AppBtn(
                onPressed: () => Navigator.pop(context, true),
                title: LocaleKeys.yes.tr(),
                textColor: context.primaryColorLight,
                backgroundColor: context.primaryColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppBtn(
                onPressed: () => Navigator.pop(context, false),
                textColor: context.primaryColor,
                title: LocaleKeys.no.tr(),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
