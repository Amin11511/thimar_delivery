import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../core/theming/app_color.dart';
import '../../cubit/verify_code_cubit.dart';

class OtpFieldsWidget extends StatelessWidget {
  final String phone;
  final bool isActiveAccount;
  final VerifiCodeCubit cubit;

  const OtpFieldsWidget({
    super.key,
    required this.phone,
    required this.isActiveAccount,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      validator: (value) {
        if (value == null) {
          return "Can't do this";
        }
        return null;
      },
      appContext: (context),
      length: 4,
      animationType: AnimationType.slide,
      controller: cubit.otpController,
      keyboardType: TextInputType.number,
      cursorColor: Theme.of(context).primaryColor,
      onAutoFillDisposeAction: AutofillContextAction.commit,
      onChanged: (value) {
        if (value.length == 4) {
          // FocusScope.of(context).unfocus();
          // isActiveAccount
          //     ? cubit.verifiedAccount(phone, context)
          //     : cubit.checkCode(phone, context);
        }
      },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        isActiveAccount
            ? cubit.verifyCode(phone)
            : cubit.checkCode(phone);
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        fieldHeight: 60.h,
        fieldWidth: 60.h,
        borderRadius: BorderRadius.circular(16.r),
        selectedColor: AppColors.lightGrayColor,
        activeFillColor: Colors.white,
        inactiveColor: AppColors.lightGrayColor,
        activeColor: AppColors.lightGrayColor,
        borderWidth: 1,
      ),
    );
  }
}