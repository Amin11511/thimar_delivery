import 'package:thimar_driver/core/utils/enums.dart';
import '../models/order_details_model.dart';

class OrderDetailsState {
  final RequestState orderDetailsState;
  final String msg;
  final ErrorType errorType;
  final OrderDetailsModel? orderDetailsModel;

  OrderDetailsState({
    this.orderDetailsState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.orderDetailsModel,
  });

  OrderDetailsState copyWith({
    RequestState? orderDetailsState,
    String? msg,
    ErrorType? errorType,
    OrderDetailsModel? orderDetailsModel,
  }) {
    return OrderDetailsState(
      orderDetailsState: orderDetailsState ?? this.orderDetailsState,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
      orderDetailsModel: orderDetailsModel ?? this.orderDetailsModel,
    );
  }
}