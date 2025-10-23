import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import '../../../core/services/server_gate.dart';
import '../models/pending_order_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(homeState: RequestState.initial)) {
    scrollController.addListener(_onScroll);
  }

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  final ScrollController scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore &&
        hasMoreData) {
      getPendingOrders(loadMore: true);
    }
  }

  Future<void> getPendingOrders({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore) return;
      isLoadingMore = true;
      emit(state.copyWith(isLoadingMore: true));
      currentPage++;
    } else {
      currentPage = 1;
      hasMoreData = true;
      emit(state.copyWith(homeState: RequestState.loading));
    }

    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.pendingOrdersEp,
      params: {'page': currentPage},
    );
    if (!result.success) {
      if (loadMore) isLoadingMore = false;
      emit(
        state.copyWith(
          homeState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
          isLoadingMore: false,
        ),
      );
      return;
    }
    final newModel = PendingOrdersModel.fromJson(result.data);
    hasMoreData = newModel.meta.currentPage < newModel.meta.lastPage;
    PendingOrdersModel updatedModel;

    if (loadMore && state.pendingOrdersModel != null) {
      final mergedData = [...state.pendingOrdersModel!.data, ...newModel.data];
      updatedModel = newModel;
      updatedModel.data = mergedData;
    } else {
      updatedModel = newModel;
    }

    isLoadingMore = false;
    emit(
      state.copyWith(
        homeState: RequestState.done,
        pendingOrdersModel: updatedModel,
        isLoadingMore: false,
        hasMoreData: hasMoreData,
      ),
    );
  }

  void resetCubit() {
    currentPage = 1;
    hasMoreData = true;
    emit(
      state.copyWith(homeState: RequestState.initial, pendingOrdersModel: null),
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}