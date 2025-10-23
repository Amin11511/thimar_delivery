import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/orders/view/widgets/current_orders_tab.dart';
import 'package:thimar_driver/features/orders/view/widgets/finish_orders_tap.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/theming/app_styles.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../cubit/orders_cubit.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> with TickerProviderStateMixin {
  late TabController _tabController;
  final ordersCubit = sl<OrdersCubit>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0) {
        ordersCubit.getCurrentOrders();
      } else if (_tabController.index == 1) {
        // ordersCubit.getFinishOrders();
      }
    });

    ordersCubit.getCurrentOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        appBarTitle: "طلباتي",
        isHaveBackButton: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Container(
              height: 55.h,
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.lighterGreenColor,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "الحالية"),
                  Tab(text: "المنتهية"),
                ],
                labelColor: AppColors.whiteColor,
                unselectedLabelColor: AppColors.grayColor,
                automaticIndicatorColorAdjustment: true,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor,
                ),
                indicatorColor: AppColors.primaryColor,
                labelStyle: AppStyles.font16WhiteBold,
                unselectedLabelStyle: AppStyles.font20BlackMedium,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocProvider.value(
                    value: ordersCubit,
                    child: CurrentOrdersTap(
                      ordersCubit: ordersCubit,
                    ),
                  ),
                  BlocProvider.value(
                    value: ordersCubit,
                    child: FinishOrdersTap(
                      orderCubit: ordersCubit,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}