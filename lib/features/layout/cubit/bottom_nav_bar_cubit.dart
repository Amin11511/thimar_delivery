import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/theming/app_assets.dart';
import '../../home/view/home_view.dart';
import '../../notifications/view/notifications_view.dart';
import '../../orders/view/orders_view.dart';
import '../../profile/view/profile_view.dart';
import 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarState());

  int get currentIndex => state.currentIndex;

  void changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  List<Widget> bottomNavScreens = [
    HomeView(),
    OrdersView(),
    NotificationView(),
    ProfileView(),
  ];

  List<String> labels = ["الرئيسية", "طلباتي", "الإشعارات", "حسابي"];
  List<String> selectedIcons = [
    AppAssets.homeIcon,
    AppAssets.orderIcon,
    AppAssets.notificationIcon,
    AppAssets.userIcon,
  ];
  List<String> unSelectedIcons = [
    AppAssets.homeIcon,
    AppAssets.orderIcon,
    AppAssets.notificationIcon,
    AppAssets.userIcon,
  ];
}
