import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/features/auth/register/cubit/register_cubit.dart';

import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_custom_botton.dart';
import '../../../../../core/widgets/auth_text_and_botton_row_widget.dart';
import '../../cubit/register_state.dart';

class RegisterButtonsWidget extends StatelessWidget {
  final int currentStep;
  final VoidCallback onTap;
  final VoidCallback onBack;

  const RegisterButtonsWidget({
    super.key,
    required this.currentStep,
    required this.onTap,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return AppCustomButton(
              isLoading: state.registerState == RequestState.loading,
              onPressed: onTap,
              textButton: currentStep == 0 ? "التالى" : "تسجيل",
            );
          },
        ),
        verticalSpace(16),
        currentStep == 1
            ? AppCustomButton(
          // isLoading: state.registerState == RequestState.loading,
          onPressed: onBack,
          textButton: "رجوع",
        )
            : SizedBox.shrink(),
        verticalSpace(8),
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