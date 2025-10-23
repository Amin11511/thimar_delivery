import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/features/notifications/models/notifications_response_model.dart';

class NotificationsState {
  final RequestState requestState;
  final String errorMessage;
  final ErrorType errorType;
  final NotificationResponseModel? notifications;
  final bool? isLoadingMore;
  final bool? hasMoreData;


  NotificationsState({
    this.requestState = RequestState.loading,
    this.errorMessage = '',
    this.errorType = ErrorType.none,
    this.notifications,
    this.isLoadingMore = false,
    this.hasMoreData = true,
  });
  NotificationsState copyWith({
    RequestState? requestState,
    String? errorMessage,
    ErrorType? errorType,
    NotificationResponseModel? notifications,
    bool? isLoadingMore,
    bool? hasMoreData,
  }) {
    return NotificationsState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
      errorType: errorType ?? this.errorType,
      notifications: notifications ?? this.notifications,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}