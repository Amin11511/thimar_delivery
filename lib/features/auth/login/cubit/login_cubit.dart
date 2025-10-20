import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import '../../../../core/services/local_notification_services.dart';
import '../../../../core/widgets/flash_helper.dart';
import '../models/login_request_body.dart';
import '../models/user_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final phoneController = TextEditingController(
    text: kDebugMode ? "0502711334" : "",
  );
  final passwordController = TextEditingController(
    text: kDebugMode ? "123456789" : "",
  );
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.loginEp,
      body: LoginRequestBody(
        phone: phoneController.text,
        password: passwordController.text,
        device_token: await GlobalNotification.getFcmToken(),
        type: Platform.operatingSystem,
        user_type: 'driver',
      ).toJson(),
    );
    if (result.success) {
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
      push(NamedRoutes.bottomNavBarLayout);
      UserModel.i.fromJson(result.data);
      UserModel.i.save();
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(requestState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(logoutState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.logoutEP);
    if (result.success) {
      UserModel.i.clear();
      UserModel.i.save();
      emit(state.copyWith(logoutState: RequestState.done, msg: result.msg));
      push(NamedRoutes.login);
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(logoutState: RequestState.error, msg: result.msg));
    }
  }
}