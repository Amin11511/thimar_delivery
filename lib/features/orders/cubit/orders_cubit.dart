import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/features/orders/models/current_order_model.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState(ordersState: RequestState.initial)) {
    scrollController.addListener(_onScroll);
  }

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  final ScrollController scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 400 &&
        !isLoadingMore &&
        hasMoreData) {
      getCurrentOrders(loadMore: true);
    }
  }

  Future<void> getCurrentOrders({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore||!hasMoreData) return;
      isLoadingMore = true;
      emit(state.copyWith(isLoadingMore: true));
      currentPage++;
    } else {
      currentPage = 1;
      hasMoreData = true;
      emit(state.copyWith(ordersState: RequestState.loading));
    }

    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.currentOrderEp,
      params: {'page': currentPage},
    );
    if (!result.success) {
      if (loadMore) isLoadingMore = false;
      emit(
        state.copyWith(
          ordersState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
          isLoadingMore: false,
        ),
      );
      return;
    }

    final newModel = CurrentOrdersModel.fromJson(result.data);
    hasMoreData = newModel.meta.currentPage < newModel.meta.lastPage;
    CurrentOrdersModel updateModel;

    if (loadMore && state.currentOrdersModel != null) {
      final mergedData = [...?state.currentOrdersModel?.data, ...newModel.data];
      updateModel = newModel;
      updateModel.data = mergedData;
    } else {
      updateModel = newModel;
    }
    isLoadingMore = false;

    emit(
      state.copyWith(
        ordersState: RequestState.done,
        currentOrdersModel: updateModel,
        isLoadingMore: false,
        hasMoreData: hasMoreData,
      ),
    );
  }

  Future<void> getFinishedOrders({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore || !hasMoreData) return;
      isLoadingMore = true;
      emit(state.copyWith(isLoadingMore: true));
      currentPage++;
    } else {
      currentPage = 1;
      hasMoreData = true;
      emit(state.copyWith(ordersState: RequestState.loading));
    }

    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.finishedOrderEp,
      params: {'page': currentPage},
    );

    if (!result.success) {
      if (loadMore) isLoadingMore = false;
      emit(
        state.copyWith(
          ordersState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
          isLoadingMore: false,
        ),
      );
      return;
    }

    final newModel = CurrentOrdersModel.fromJson(result.data);
    hasMoreData = newModel.meta.currentPage < newModel.meta.lastPage;
    CurrentOrdersModel updateModel;

    if (loadMore && state.currentOrdersModel != null) {
      final mergedData = [...?state.currentOrdersModel?.data, ...newModel.data];
      updateModel = newModel;
      updateModel.data = mergedData;
    } else {
      updateModel = newModel;
    }

    isLoadingMore = false;

    emit(
      state.copyWith(
        ordersState: RequestState.done,
        currentOrdersModel: updateModel,
        isLoadingMore: false,
        hasMoreData: hasMoreData,
      ),
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}