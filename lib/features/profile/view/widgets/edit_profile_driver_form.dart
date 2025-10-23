import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/profile/cubit/profile_cubit.dart';
import 'package:thimar_driver/features/profile/models/profile_data_model.dart';
import '../../../../core/theming/app_assets.dart';
import '../../../../core/theming/app_color.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/auth_phone_and_country_widget.dart';

class EditProfileDriverFrom extends StatelessWidget {
  final ProfileCubit profileCubit;
  final ProfileDataModel data;

  const EditProfileDriverFrom({
    super.key,
    required this.profileCubit,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),

      child: Column(
        children: [
          verticalSpace(16),
          AppTextFormField(
            hintText: "اسم المستخدم",
            controller: profileCubit.nameController
              ..text = data.data?.fullname ?? "",
            fillColor: AppColors.lighterGreenColor,
            validator: (value) {
              if (value.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
            },
            prefixIcon: Image.asset(
              AppAssets.personIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AuthPhoneAndCountryWidget(
            phoneController: profileCubit.phoneController
              ..text = data.data?.phone ?? "",
            fillColor: AppColors.lighterGreenColor,
          ),
          verticalSpace(16),
          AppTextFormField(
            fillColor: AppColors.lighterGreenColor,
            hintText: "المدينة",
            controller: profileCubit.cityController
              ..text = data.data?.cityId.toString() ?? "",
            validator: (value) {
              if (value.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
            },
            prefixIcon: Image.asset(
              AppAssets.flagImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            fillColor: AppColors.lighterGreenColor,
            hintText: "رقم الهوية",
            controller: profileCubit.identityNumberController
              ..text = data.data?.identityNumber ?? "",
            validator: (value) {
              if (value.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
            },
            prefixIcon: Image.asset(
              AppAssets.userGrayIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            enabled: false,
            onTap: () {},
            fillColor: AppColors.lighterGreenColor,
            hintText: "كلمة المرور",
            validator: (value) {},
            prefixIcon: Image.asset(
              AppAssets.lockImage,
              width: 22.w,
              height: 22.h,
            ),
            suffixIcon: Image.asset(
              AppAssets.arrowLeftImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
        ],
      ),
    );
  }
}