import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/core/widgets/app_custom_error_widget.dart';
import 'package:thimar_driver/features/orders/models/current_order_model.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/widgets/app_loading_indicator_widget.dart';
import '../../../home/models/show_order_data_model.dart';
import '../../../home/view/widgets/order_state_single_item.dart';
import '../../cubit/orders_cubit.dart';
import '../../cubit/orders_state.dart';

class CurrentOrdersTap extends StatefulWidget {
  final OrdersCubit ordersCubit;

  const CurrentOrdersTap({super.key, required this.ordersCubit});

  @override
  State<CurrentOrdersTap> createState() => _CurrentOrdersTapState();
}

class _CurrentOrdersTapState extends State<CurrentOrdersTap> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.ordersState == RequestState.loading) {
            return Center(child: AppLoadingIndicatorWidget());
          } else if (state.ordersState == RequestState.done) {
            return setupSuccess(state.currentOrdersModel!);
          } else if (state.ordersState == RequestState.error) {
            return AppCustomErrorWidget(error: state.msg);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget setupSuccess(CurrentOrdersModel? data) {
    return data!.data == null || data.data.isEmpty
        ? Center(
      child: Text(
        "لا يوجد طلبات حالية",
        style: AppStyles.font16GreenBold,
      ),
    )
        : Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.data.length,
            shrinkWrap: true,
            controller: widget.ordersCubit.scrollController,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final order = data.data[index];

              DateTime? orderDate = order.date != null
                  ? DateTime.tryParse(order.date.toString())
                  : null;

              String formattedDate = orderDate != null
                  ? DateFormat("dd, MMMM, yyyy", "ar").format(orderDate)
                  : "";
              return GestureDetector(
                onTap: () {
                  push(NamedRoutes.orderDetails, arg: order.orderId);
                },
                child: OrderStateSingleItem(
                  order: ShowOrderModel(
                    orderDate: formattedDate,
                    orderStatus: order.status,
                    orderNumber: order.orderId.toString(),
                    orderPrice: order.totalPrice != null
                        ? (order.totalPrice! as num).toDouble()
                        : 0.0,
                    products: order.images ?? [],
                    ordersCubit: widget.ordersCubit,
                    userLocation: order.location,
                    userName: order.clientName,
                    userImage: order.clientImage,
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<OrdersCubit, OrdersState>(
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