import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/features/notifications/models/notifications_response_model.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit()
      : super(NotificationsState(requestState: RequestState.initial)) {
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
      loadNotifications(loadMore: true);
    }
  }

  Future<void> loadNotifications({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore || !hasMoreData) return;
      isLoadingMore = true;
      emit(state.copyWith(isLoadingMore: true));
      currentPage++;
    } else {
      currentPage = 1;
      hasMoreData = true;
      emit(state.copyWith(requestState: RequestState.loading));
    }

    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.notificationsEP,
      params: {'page': currentPage},
    );

    if (!result.success) {
      if (loadMore) isLoadingMore = false;
      emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: result.msg,
        isLoadingMore: false,
      ));
      return;
    }

    final newModel = NotificationResponseModel.fromJson(result.data);
    hasMoreData = newModel.meta.currentPage < newModel.meta.lastPage;

    NotificationResponseModel updatedModel;
    if (loadMore && state.notifications != null) {
      final mergedList = [
        ...state.notifications!.data.notifications,
        ...newModel.data.notifications,
      ];
      updatedModel = newModel;
      updatedModel.data.notifications = mergedList;
    } else {
      updatedModel = newModel;
    }

    isLoadingMore = false;

    emit(state.copyWith(
      notifications: updatedModel,
      requestState: RequestState.done,
      isLoadingMore: false,
      hasMoreData: hasMoreData,
    ));
  }

  void resetCubit() {
    currentPage = 1;
    hasMoreData = true;
    emit(state.copyWith(
      requestState: RequestState.initial,
      notifications: null,
    ));
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}