import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_styles.dart';
import '../../../../core/utils/spacing.dart';

class ContactCustomRow extends StatelessWidget {
  final String title;
  final String iconPath;

  const ContactCustomRow(
      {super.key, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          width: 20.w,
          height: 20.h,
          fit: BoxFit.cover,
        ),
        horizontalSpace(8),
        Flexible(
          child: Text(
            title,
            style: AppStyles.font16DarkerGrayLight,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}