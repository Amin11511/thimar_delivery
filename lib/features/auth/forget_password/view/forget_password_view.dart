import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/features/auth/forget_password/cubit/forget_password_cubit.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_custom_botton.dart';
import '../../../../core/widgets/auth_background_custom_image.dart';
import '../../../../core/widgets/auth_header_widget.dart';
import '../../../../core/widgets/auth_phone_and_country_widget.dart';
import '../../../../core/widgets/auth_text_and_botton_row_widget.dart';
import '../cubit/forget_password_state.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<ForgetPasswordCubit>();
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
                      subTitle: "أدخل رقم الجوال المرتبط بحسابك",
                    ),
                    Form(
                      key: cubit.formKey,
                      child: AuthPhoneAndCountryWidget(
                        phoneController: cubit.phoneController,
                      ),
                    ),
                    verticalSpace(24),

                    BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                      builder: (context, state) {
                        // if (state.requestState == RequestState.done) {
                        //   push(
                        //     NamedRoutes.verifiedView,
                        //     arg: {
                        //       'phone': cubit.phoneController.text,
                        //       'isActiveAccount': false,
                        //     },
                        //   );
                        // }
                        return AppCustomButton(
                          isLoading: state.requestState == RequestState.loading,
                          textButton: "تأكيد رقم الجوال",
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.forgetPassword();
                            }
                          },
                        );
                      },
                    ),
                    verticalSpace(45),
                    AuthTextAndButtonRowWidget(
                      text: "لديك حساب بالفعل ؟",
                      buttonText: "تسجيل الدخول",
                      onPressed: () {},
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