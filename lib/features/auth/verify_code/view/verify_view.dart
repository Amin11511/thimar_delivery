import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/features/auth/verify_code/view/widgets/counter_down_and_send_botton_widget.dart';
import 'package:thimar_driver/features/auth/verify_code/view/widgets/otp_field_widget.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_custom_botton.dart';
import '../../../../core/widgets/auth_background_custom_image.dart';
import '../../../../core/widgets/auth_header_widget.dart';
import '../../../../core/widgets/auth_text_and_botton_row_widget.dart';
import '../cubit/verify_code_cubit.dart';
import '../cubit/verify_code_state.dart';

class VerifiedView extends StatefulWidget {
  final String phone;
  final bool isActiveAccount;

  const VerifiedView({
    super.key,
    required this.phone,
    required this.isActiveAccount,
  });

  @override
  State<VerifiedView> createState() => _VerifiedViewState();
}

class _VerifiedViewState extends State<VerifiedView> {
  final CountDownController _controller = CountDownController();
  final cubit = sl<VerifiCodeCubit>();

  @override
  Widget build(BuildContext context) {
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
                      title: widget.isActiveAccount
                          ? "تفعيل الحساب"
                          : "نسيت كلمة المرور",
                      subTitle:
                      "أدخل الكود المكون من 4 أرقام المرسل علي رقم الجوال",
                      isHasButton: true,
                      phoneNumber: widget.phone,
                      onPressed: () {},
                    ),
                    OtpFieldsWidget(
                      phone: widget.phone,
                      isActiveAccount: widget.isActiveAccount,
                      cubit: cubit,
                    ),
                    verticalSpace(28),
                    BlocBuilder<VerifiCodeCubit, VerifiCodeState>(
                      builder: (context, state) {
                        return AppCustomButton(
                          isLoading: state.requestState == RequestState.loading,
                          textButton: "تأكيد الكود",
                          onPressed: () {
                            widget.isActiveAccount == true
                                ? cubit.verifyCode(widget.phone)
                                : cubit.checkCode(widget.phone);
                          },
                        );
                      },
                    ),
                    Builder(
                      builder: (context) => CounterDownAndSendButtonWidget(
                        controller: _controller,
                        cubit: cubit,
                        phone: widget.phone,
                      ),
                    ),
                    AuthTextAndButtonRowWidget(
                      text: "لديك حساب بالفعل ؟",
                      buttonText: "تسجيل الدخول",
                      onPressed: () {
                        push(NamedRoutes.login);
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