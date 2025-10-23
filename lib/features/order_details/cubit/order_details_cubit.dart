import 'package:bloc/bloc.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import '../../../core/utils/enums.dart';
import '../models/order_details_model.dart';
import 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsState());

  Future<void> getOrderDetails(int orderId) async {
    emit(state.copyWith(orderDetailsState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.orderDetailsEp(orderId),
    );
    if (result.success) {
      final data = result.data;
      final model = OrderDetailsModel.fromJson(data);
      emit(
        state.copyWith(
          orderDetailsState: RequestState.done,
          orderDetailsModel: model,
        ),
      );
    } else {
      emit(
        state.copyWith(
          orderDetailsState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
        ),
      );
    }
  }
}