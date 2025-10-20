import 'package:thimar_driver/core/utils/enums.dart';

class NewPasswordState {

  final RequestState requestState;
  final String msg;
  final ErrorType errorType;

  NewPasswordState({
    this.requestState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  NewPasswordState copyWith({
    RequestState? requestState,
    String? msg,
    ErrorType? errorType,
  }) =>
      NewPasswordState(
        requestState: requestState ?? this.requestState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}