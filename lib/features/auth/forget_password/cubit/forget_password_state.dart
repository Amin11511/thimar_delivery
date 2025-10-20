import 'package:thimar_driver/core/utils/enums.dart';

class ForgetPasswordState {
  final RequestState requestState;
  final String msg;
  final ErrorType errorType;

  ForgetPasswordState({
    this.requestState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  ForgetPasswordState copyWith({
    RequestState? requestState,
    String? msg,
    ErrorType? errorType,
  }) =>
      ForgetPasswordState(
        requestState: requestState ?? this.requestState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );

}