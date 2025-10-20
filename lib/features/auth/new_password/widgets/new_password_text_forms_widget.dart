import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_assets.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../cubit/new_password_cubit.dart';

class NewPasswordTextFormsWidget extends StatelessWidget {
  final NewPasswordCubit cubit;
  const NewPasswordTextFormsWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          verticalSpace(16),
          AppTextFormField(
            controller: cubit.passwordController,
            hintText: "كلمة المرور",
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل كلمة مرور صحيحة";
              }
              if (value.length < 6) {
                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.lockImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            hintText: "كلمة المرور",
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل كلمة مرور صحيحة";
              }
              if (value !=
                  cubit.passwordController.text) {
                return "كلمة المرور غير متطابقة";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.lockImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(30),
        ],
      ),
    );
  }
}