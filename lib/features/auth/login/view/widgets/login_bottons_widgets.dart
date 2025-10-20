import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/features/auth/login/cubit/login_cubit.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_btn.dart';
import '../../cubit/login_state.dart';

class LoginButtonsWidget extends StatelessWidget {
  final LoginCubit cubit;

  const LoginButtonsWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              push(NamedRoutes.forgetPasswordView);
            },
            child: Text(
              "نسيت كلمة المرور؟",
              style: AppStyles.font16DarkGrayLight,
            ),
          ),
        ),
        verticalSpace(30),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return AppBtn(
              title: "تسجيل الدخول",
              radius: 16.r,
              onPressed: () {
                cubit.login();
              },
              loading: state.requestState.isLoading,
            );
          },
        ),
      ],
    );
  }
}