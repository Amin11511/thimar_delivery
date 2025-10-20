import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/widgets/flash_helper.dart';
import '../../../../core/routing/app_routes_fun.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/enums.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordState());
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future<void> forgetPassword() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.forgetPasswordEP,
      formData: {"phone": phoneController.text},
    );

    if (result.success) {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
      push(
        NamedRoutes.verifiedView,
        arg: {
          'phone': phoneController.text,
          'isActiveAccount': false,
        },
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