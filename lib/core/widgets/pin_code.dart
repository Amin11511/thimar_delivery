import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thimar_driver/core/utils/extentions.dart';

class CustomPinCode extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onCompleted;
  const CustomPinCode({super.key, this.controller, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        pastedTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        length: 4,
        hintCharacter: '-',
        controller: controller,
        obscureText: false,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        hintStyle: TextStyle(color: context.hintColor),
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          activeColor: context.hoverColor,
          selectedColor: context.secondaryColor,
          activeFillColor: context.scaffoldBackgroundColor,
          borderWidth: 1.r,
          // activeFillColor: context.theme.scaffoldBackgroundColor,
          selectedFillColor: context.scaffoldBackgroundColor,
          inactiveColor: context.hoverColor,
          inactiveFillColor: context.scaffoldBackgroundColor,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.r),
          fieldHeight: 60.w,
          fieldWidth: 60.w,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.number,
        animationCurve: Curves.easeInOutQuad,
        enablePinAutofill: true,
        useExternalAutoFillGroup: true,
        onChanged: (value) {},
        onCompleted: onCompleted,
        beforeTextPaste: (text) {
          return false;
        },
      ),
    );
  }
}
