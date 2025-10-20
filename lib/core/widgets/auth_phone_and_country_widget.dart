import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/app_assets.dart';
import '../../../core/theming/app_styles.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../theming/app_color.dart';

class AuthPhoneAndCountryWidget extends StatelessWidget {
  final TextEditingController? phoneController;
  final Color? fillColor;

  const AuthPhoneAndCountryWidget(
      {super.key, this.phoneController, this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightGrayColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(16.r),
              color: fillColor ?? AppColors.whiteColor,
            ),
            child: Center(
              child: CountryCodePicker(
                onChanged: _onCountryChange,
                initialSelection: 'SA',
                favorite: ['+966', 'SA'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                builder: (countryCode) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        countryCode!.flagUri!,
                        package: 'country_code_picker',
                        width: 24.w,
                        height: 18.h,
                      ),
                      horizontalSpace(6),
                      Text(
                        countryCode.dialCode ?? "",
                        style: AppStyles.font16GreenMedium,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        horizontalSpace(8),
        Flexible(
          flex: 4,
          child: AppTextFormField(
            controller: phoneController,
            hintText: "رقم الجوال",
            validator: (value) {
              if (value.isEmpty) {
                return 'يرجى إدخال رقم الجوال';
              }
            },
            keyboardType: TextInputType.phone,
            prefixIcon: Image.asset(
              AppAssets.phoneImage,
              width: 22.w,
              height: 22.h,
            ),
            fillColor: fillColor ?? AppColors.whiteColor,
          ),
        ),
      ],
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    print("New Country selected: $countryCode");
  }
}