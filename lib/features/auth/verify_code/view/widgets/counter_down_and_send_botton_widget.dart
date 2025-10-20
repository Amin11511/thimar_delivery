import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_color.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_custom_botton.dart';

class CounterDownAndSendButtonWidget extends StatefulWidget {
  final CountDownController controller;
  final dynamic cubit;

  // final ForgetPasswordCubit forgetPasswordCubit;
  final String phone;

  const CounterDownAndSendButtonWidget({
    super.key,
    required this.controller,
    // required this.forgetPasswordCubit,
    required this.phone, this.cubit,
  });

  @override
  State<CounterDownAndSendButtonWidget> createState() =>
      _CounterDownWidgetState();
}

class _CounterDownWidgetState extends State<CounterDownAndSendButtonWidget> {
  final int _duration = 30;
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(28),
        Text(
          "لم تستلم الكود ؟\nيمكنك إعادة إرسال الكود بعد",
          style: AppStyles.font16DarkGrayLight,
          textAlign: TextAlign.center,
        ),
        verticalSpace(20),
        CircularCountDownTimer(
          width: 66.w,
          height: 66.h,
          duration: _duration,
          initialDuration: 22,
          isReverse: true,
          textFormat: CountdownTextFormat.MM_SS,
          strokeWidth: 3.w,
          controller: widget.controller,
          ringColor: AppColors.primaryColor,
          fillColor: AppColors.lightGrayColor,
          strokeCap: StrokeCap.round,
          textStyle: AppStyles.font16DarkGrayLight,
          textAlign: TextAlign.center,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _isButtonEnabled = false;
                });
              }
            });
          },
          onComplete: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _isButtonEnabled = true;
                });
              }
            });
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (duration.inSeconds == 0) {
              return "00:00";
            } else {
              return Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
        verticalSpace(20),
        AppCustomButton(
          textButton: "إعادة الإرسال",
          onPressed: () {},
          // _isButtonEnabled
          //     ? () {
          //         widget.controller.restart(duration: _duration);
          //         widget.cubit.sendCode(context, widget.phone);
          //         context.read<VerifiedCodeCubit>().resendCode(widget.phone);
          //         WidgetsBinding.instance.addPostFrameCallback((_) {
          //           if (mounted) {
          //             setState(() {
          //               _isButtonEnabled = false;
          //             });
          //           }
          //         });
          //       }
          //     : null,
          isBorder: true,
          btnWidth: 133.w,
          btnHeight: 47.h,
          radius: 16.r,
          textColor: AppColors.primaryColor,
        ),
        verticalSpace(45),
      ],
    );
  }
}