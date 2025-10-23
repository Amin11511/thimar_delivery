import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/order_details/models/order_details_model.dart';
import '../../../../core/theming/app_assets.dart';
import '../../../../core/theming/app_color.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/utils/spacing.dart';

class OrderDetailsPrices extends StatelessWidget {
  final OrderDetailsModel data;

  const OrderDetailsPrices({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final order = data.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(16),
        Text("ملخص الطلب", style: AppStyles.font16GreenBold),
        verticalSpace(16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lighterGreenColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              verticalSpace(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Text("إجمالي المنتجات", style: AppStyles.font16GreenMedium),
                    const Spacer(),
                    Text(
                      order?.orderPrice != null
                          ? "${order?.orderPrice} ر.س"
                          : "0 ر.س",
                      style: AppStyles.font16GreenMedium,
                    ),
                  ],
                ),
              ),
              verticalSpace(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Text("سعر التوصيل", style: AppStyles.font16GreenBold),
                    const Spacer(),
                    Text(
                      //price
                      order?.deliveryPrice != null
                          ? "${order?.deliveryPrice} ر.س"
                          : "0 ر.س",
                      style: AppStyles.font16GreenMedium,
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.grayColor),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Text("المجموع", style: AppStyles.font20GreenBold),
                    const Spacer(),
                    Text(
                      order?.totalPrice != null
                          ? "${order?.totalPrice} ر.س"
                          : "0 ر.س",
                      style: AppStyles.font20GreenBold,
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.grayColor),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("تم الدفع بواسطة", style: AppStyles.font16GreenMedium),
                    horizontalSpace(8),
                    Image.asset(
                      order?.payType == "visa"
                          ? AppAssets.visaIcon
                          : order?.payType == "master"
                          ? AppAssets.masterIcon
                          : AppAssets.moneyIcon,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ],
                ),
              ),
              verticalSpace(8),
            ],
          ),
        ),
      ],
    );
  }
}