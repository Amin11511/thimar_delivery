import 'package:thimar_driver/core/utils/enums.dart';

class LoginState {
  final RequestState requestState;
  final String msg;
  final ErrorType errorType;

  final RequestState logoutState;
  final String logoutMsg;
  final ErrorType logoutErrorType;

  LoginState({
    this.requestState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.logoutState = RequestState.initial,
    this.logoutMsg = '',
    this.logoutErrorType = ErrorType.none,
  });
  LoginState copyWith({
    RequestState? requestState,
    String? msg,
    ErrorType? errorType,
    RequestState? logoutState,
    String? logoutMsg,
    ErrorType? logoutErrorType,
  }) =>
      LoginState(
        requestState: requestState ?? this.requestState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
        logoutState: logoutState ?? this.logoutState,
        logoutMsg: logoutMsg ?? this.logoutMsg,
        logoutErrorType: logoutErrorType ?? this.logoutErrorType,
      );
}