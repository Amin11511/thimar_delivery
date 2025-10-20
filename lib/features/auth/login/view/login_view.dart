import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/core/utils/spacing.dart';
import 'package:thimar_driver/core/widgets/auth_header_widget.dart';
import 'package:thimar_driver/features/auth/login/cubit/login_cubit.dart';
import 'package:thimar_driver/features/auth/login/view/widgets/login_bottons_widgets.dart' show LoginButtonsWidget;
import 'package:thimar_driver/features/auth/login/view/widgets/login_text_forms_widget.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/widgets/auth_background_custom_image.dart';
import '../../../../core/widgets/auth_text_and_botton_row_widget.dart' show AuthTextAndButtonRowWidget;

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<LoginCubit>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AuthBackgroundCustomImage(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BlocProvider.value(
                value: cubit,
                child: Column(
                  children: [
                    AuthHeaderWidget(),
                    LoginTextFormsWidget(loginCubit: cubit),
                    LoginButtonsWidget(cubit: cubit),
                    verticalSpace(32),
                    AuthTextAndButtonRowWidget(
                      text: "ليس لديك حساب ؟",
                      buttonText: "تسجيل الأن",
                      onPressed: () {
                        push(NamedRoutes.register);
                      },
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