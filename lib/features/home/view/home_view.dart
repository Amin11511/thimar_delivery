import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/core/theming/app_assets.dart';
import 'package:thimar_driver/core/theming/app_styles.dart';
import 'package:thimar_driver/core/utils/spacing.dart';
import 'package:thimar_driver/core/widgets/app_custom_search_bar.dart';
import 'package:thimar_driver/core/widgets/app_loading_indicator_widget.dart';
import 'package:thimar_driver/features/home/cubit/home_cubit.dart';
import 'package:thimar_driver/features/home/cubit/home_state.dart';
import 'package:thimar_driver/features/home/models/show_order_data_model.dart';
import 'package:thimar_driver/features/home/view/widgets/order_state_single_item.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../models/pending_order_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final cubit = sl<HomeCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getPendingOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppCustomAppBar(
          appBarTitle: "الرئيسية",
          isHaveBackButton: false,
          widget: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.thimarIcon,
                    height: 45.h,
                    width: 45.w,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "سلة ثمار",
                    style: AppStyles.font16GreenBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                AppCustomSearchBar(),
                verticalSpace(32),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.homeState == RequestState.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.homeState == RequestState.error) {
                        return Center(
                          child: Text(
                            state.msg.isNotEmpty
                                ? state.msg
                                : "حدث خطأ أثناء تحميل الطلبات",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      final orders = state.pendingOrdersModel;
                      if (orders!.data.isEmpty) {
                        return const Center(
                          child: Text("لا توجد طلبات حالياً"),
                        );
                      }
                      return setupSuccess(orders);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column setupSuccess(PendingOrdersModel orders) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: orders.data.length,
            controller: cubit.scrollController,
            itemBuilder: (context, index) {
              if (index == orders.data.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final order = orders.data[index];

              DateTime? orderDate = DateTime.tryParse(order.date.toString());

              String formattedDate = orderDate != null
                  ? DateFormat("dd, MMMM, yyyy", "ar").format(orderDate)
                  : "";

              return GestureDetector(
                onTap: () {
                  push(NamedRoutes.orderDetails, arg: order.orderId);
                },
                child: OrderStateSingleItem(
                  order: ShowOrderModel(
                    ordersCubit: cubit,
                    orderDate: formattedDate,
                    orderNumber: order.orderId.toString(),
                    orderPrice: order.totalPrice,
                    orderStatus: order.status,
                    products: order.images,
                    userImage: order.clientImage,
                    userName: order.clientName,
                    userLocation: order.address.location,
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (BuildContext context, state) {
            if (state.isLoadingMore == true) {
              return AppLoadingIndicatorWidget();
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}