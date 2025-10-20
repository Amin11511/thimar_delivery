import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/core/widgets/flash_helper.dart';
import 'package:thimar_driver/features/auth/verify_code/cubit/verify_code_state.dart';
import '../../../../core/routing/app_routes_fun.dart';
import '../../../../core/routing/routes.dart';
import '../models/verify_request_body.dart';

class VerifiCodeCubit extends Cubit<VerifiCodeState> {
  VerifiCodeCubit() : super(VerifiCodeState());
  final otpController = TextEditingController();

  Future<void> verifyCode(String phone) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.verifiEP,
      body: VerifiRequestBody(
        phone: phone.toString(),
        code: otpController.text,
        type: Platform.operatingSystem,
        deviceToken: "test",
      ).toJson(),
    );
    if (result.success) {
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
      push(NamedRoutes.login);
    } else {
      FlashHelper.showToast(result.msg);
      emit(
        state.copyWith(
          requestState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
        ),
      );
    }
  }

  Future<void> checkCode(String? phone) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.checkCodeEP,
      body: {"phone": phone.toString(), "code": otpController.text},
    );
    if (result.success) {
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
      push(
        NamedRoutes.newPasswordView,
        arg: {'phone': phone.toString(), 'code': otpController.text},
      );
    } else {
      FlashHelper.showToast(result.msg);
      emit(
        state.copyWith(
          requestState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
        ),
      );
    }
  }
}