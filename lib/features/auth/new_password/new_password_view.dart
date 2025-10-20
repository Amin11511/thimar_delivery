import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/auth/new_password/widgets/new_password_buttons_widgets.dart';
import 'package:thimar_driver/features/auth/new_password/widgets/new_password_text_forms_widget.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/widgets/auth_background_custom_image.dart';
import '../../../../core/widgets/auth_header_widget.dart';
import 'cubit/new_password_cubit.dart';

class NewPasswordView extends StatelessWidget {
  final String phone;
  final String code;

  const NewPasswordView({super.key, required this.phone, required this.code});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<NewPasswordCubit>();
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: AuthBackgroundCustomImage(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    AuthHeaderWidget(
                      title: "نسيت كلمة المرور",
                      subTitle: "أدخل كلمة المرور الجديدة",
                    ),
                    NewPasswordTextFormsWidget(cubit: cubit),
                    NewPasswordButtonsWidget(
                      phone: phone,
                      code: code,
                      cubit: cubit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}