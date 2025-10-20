import 'package:thimar_driver/core/utils/enums.dart';

class RegisterState {
  final RequestState registerState;
  final String msg;
  final ErrorType errorType;

  RegisterState({
    this.registerState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  RegisterState copyWith({
    RequestState? registerState,
    String? msg,
    ErrorType? errorType,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
    );
  }
}