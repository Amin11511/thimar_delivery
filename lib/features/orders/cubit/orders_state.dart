import 'package:thimar_driver/core/utils/enums.dart';
import '../models/current_order_model.dart';

class OrdersState {
  final RequestState ordersState;
  final String msg;
  final ErrorType errorType;
  final CurrentOrdersModel? currentOrdersModel;
  final bool? isLoadingMore;
  final bool? hasMoreData;

  OrdersState({
    this.ordersState = RequestState.loading,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.currentOrdersModel,
    this.isLoadingMore,
    this.hasMoreData,
  });

  OrdersState copyWith({
    RequestState? ordersState,
    String? msg,
    ErrorType? errorType,
    CurrentOrdersModel? currentOrdersModel,
    bool? isLoadingMore,
    bool? hasMoreData,
  }) {
    return OrdersState(
      ordersState: ordersState ?? this.ordersState,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
      currentOrdersModel: currentOrdersModel ?? this.currentOrdersModel,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}