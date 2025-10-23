import 'package:thimar_driver/core/utils/enums.dart';
import '../models/pending_order_model.dart';

class HomeState {
  final RequestState homeState;
  final String msg;
  final ErrorType errorType;

  // final List<Datum>? pendingOrders;
  final PendingOrdersModel? pendingOrdersModel;
  final bool? isLoadingMore;

  final bool? hasMoreData;

  HomeState({
    this.homeState = RequestState.loading,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.pendingOrdersModel,
    this.isLoadingMore,
    this.hasMoreData,
  });

  HomeState copyWith({
    RequestState? homeState,
    String? msg,
    ErrorType? errorType,
    PendingOrdersModel? pendingOrdersModel,
    bool? isLoadingMore,
    bool? hasMoreData,
  }) {
    return HomeState(
      homeState: homeState ?? this.homeState,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
      pendingOrdersModel: pendingOrdersModel ?? this.pendingOrdersModel,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}