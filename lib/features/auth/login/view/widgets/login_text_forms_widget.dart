import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/auth/login/cubit/login_cubit.dart';
import '../../../../../core/theming/app_assets.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/auth_phone_and_country_widget.dart';

class LoginTextFormsWidget extends StatelessWidget {
  final LoginCubit loginCubit;

  const LoginTextFormsWidget({super.key, required this.loginCubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginCubit.formKey,
      child: Column(
        children: [
          AuthPhoneAndCountryWidget(
            phoneController: loginCubit.phoneController,
          ),
          verticalSpace(16),
          AppTextFormField(
            hintText: "كلمة المرور",
            controller: loginCubit.passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'يرجى إدخال كلمة المرور';
              }
            },
            prefixIcon: Image.asset(
              AppAssets.lockImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(10),
        ],
      ),
    );
  }
}