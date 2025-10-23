import 'package:thimar_driver/core/utils/enums.dart';

class BottomNavBarState {
  final RequestState state;
  final String msg;
  final ErrorType errorType;
  final int currentIndex;

  BottomNavBarState({
    this.state = RequestState.loading,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.currentIndex = 0,
  });

  BottomNavBarState copyWith({
    RequestState? state,
    String? msg,
    ErrorType? errorType,
    int? currentIndex,
  }) {
    return BottomNavBarState(
      state: state ?? this.state,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}