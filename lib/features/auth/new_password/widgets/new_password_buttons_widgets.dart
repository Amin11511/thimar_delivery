import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_custom_botton.dart';
import '../../../../core/widgets/auth_text_and_botton_row_widget.dart';
import '../cubit/new_password_cubit.dart';
import '../cubit/new_password_state.dart';

class NewPasswordButtonsWidget extends StatelessWidget {
  final String phone;
  final String code;
  final NewPasswordCubit cubit;

  const NewPasswordButtonsWidget({
    super.key,
    required this.phone,
    required this.code,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<NewPasswordCubit, NewPasswordState>(
          builder: (context, state) {
            return AppCustomButton(
              isLoading: state.requestState == RequestState.loading,
              textButton: "تغيير كلمة المرور",
              onPressed: () {
                cubit.newPassword(phone: phone, code: code);
              },
            );
          },
        ),
        verticalSpace(45),
        AuthTextAndButtonRowWidget(
          buttonText: "تسجيل الدخول",
          text: "لديك حساب بالفعل ؟",
          onPressed: () {
            push(NamedRoutes.login);
          },
        ),
      ],
    );
  }
}