import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/widgets/flash_helper.dart';
import '../../../../../core/utils/enums.dart';
import 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit() : super(NewPasswordState());
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> newPassword({
    required String phone,
    required String code,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.resetPasswordEP,
      body: {"phone": phone, "code": code, "password": passwordController.text},
    );
    if (result.success) {
      FlashHelper.showToast(result.msg);
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
}