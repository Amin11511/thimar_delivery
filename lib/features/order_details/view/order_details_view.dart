import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/utils/spacing.dart';
import 'package:thimar_driver/core/widgets/app_custom_app_bar.dart';
import 'package:thimar_driver/features/order_details/cubit/order_details_cubit.dart';
import 'package:thimar_driver/features/order_details/cubit/order_details_state.dart';
import 'package:thimar_driver/features/order_details/view/widgets/order_details_item.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/app_custom_botton.dart';

class OrderDetailsView extends StatefulWidget {
  final int orderId;

  const OrderDetailsView({super.key, required this.orderId});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final cubit = sl<OrderDetailsCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          final data = state.orderDetailsModel;

          final isLoaded =
              state.orderDetailsState == RequestState.done && data != null;
          return Scaffold(
            appBar: !isLoaded
                ? null
                : AppCustomAppBar(appBarTitle: "طلب #${data.data?.id}"),
            bottomNavigationBar: isLoaded
                ? data.data?.status == "pending"
                ? Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: AppCustomButton(
                      textButton: "قبول",
                      onPressed: () {},
                    ),
                  ),
                  horizontalSpace(16),
                  Expanded(
                    child: AppCustomButton(
                      textButton: "رفض",
                      onPressed: () {},
                      backgroundColor: AppColors.redColor,
                    ),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.all(16.w),
              child: AppCustomButton(
                textButton: data.data?.status == "in_way"
                    ? "إنهاء الطلب"
                    : "بدء التوصيل",
                onPressed: () {
                  // data.data?.status == "in_way"?:
                },
              ),
            )
                : null,
            body: Builder(
              builder: (context) {
                final data = state.orderDetailsModel;
                if (state.orderDetailsState == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.orderDetailsState == RequestState.error) {
                  return Center(child: Text(state.msg));
                } else if (data == null) {
                  return const Center(child: Text("لا توجد بيانات"));
                }
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SingleChildScrollView(
                      child: OrderDetailsItem(data: data),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}