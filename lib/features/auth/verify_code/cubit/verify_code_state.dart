import 'package:thimar_driver/core/utils/enums.dart';
import '../models/verify_code_model.dart';

class VerifiCodeState {
  final RequestState requestState;
  final String msg;
  final ErrorType errorType;
  final VerifiCodeModel? verifiCodeModel;

  VerifiCodeState({
    this.requestState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.verifiCodeModel,
  });

  VerifiCodeState copyWith({
    RequestState? requestState,
    String? msg,
    ErrorType? errorType,
    VerifiCodeModel? verifiCodeModel,
  }) =>
      VerifiCodeState(
        requestState: requestState ?? this.requestState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
        verifiCodeModel: verifiCodeModel ?? this.verifiCodeModel,
      );
}