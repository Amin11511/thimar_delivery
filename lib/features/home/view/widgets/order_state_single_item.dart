import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/theming/app_assets.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theming/app_color.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../models/show_order_data_model.dart';

class OrderStateSingleItem extends StatelessWidget {
  final ShowOrderModel? order;

  const OrderStateSingleItem({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "طلب #${order?.orderNumber ?? ""}",
                    style: AppStyles.font16GreenBold,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusContainerColor(order?.orderStatus),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      getStatusText(order?.orderStatus),
                      style: AppStyles.font12GreenBold.copyWith(
                        color: getStatusTextColor(order?.orderStatus),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                order?.orderDate ?? "",
                style: AppStyles.font16DarkerGrayLight,
              ),
              Divider(color: AppColors.lightGrayColor),
              Row(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(25.r),
                  //   child: CachedNetworkImage(
                  //     imageUrl: order?.userImage ?? "",
                  //     width: 50.w,
                  //     height: 50.h,
                  //     fit: BoxFit.cover,
                  //     placeholder: (context, url) =>
                  //         const CircularProgressIndicator(),
                  //     errorWidget: (context, url, error) =>
                  //         Icon(Icons.error, size: 50.r),
                  //   ),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: CustomImage(
                      order?.userImage ?? "",
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  horizontalSpace(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order?.userName ?? "",
                          style: AppStyles.font16GreenBold,
                        ),
                        horizontalSpace(16),
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.locationImage,
                              width: 20.w,
                              height: 20.h,
                            ),
                            horizontalSpace(8),
                            Flexible(
                              child: Text(
                                order?.userLocation ?? "",
                                style: AppStyles.font15GrayRegular,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(color: AppColors.lightGrayColor),
              verticalSpace(16),
              Row(
                children: [
                  ...List.generate(
                    (order!.products!.length > 3 ? 3 : order!.products!.length),
                        (index) => Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          order?.products?[index].url ?? "",
                          width: 25.w,
                          height: 25.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (order!.products!.length > 3)
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: AppColors.lighterGreenColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "+${order!.products!.length - 3}",
                            style: AppStyles.font14WhiteBold.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Spacer(),
                  Text(
                    order?.orderPrice != null
                        ? "${order?.orderPrice} ر.س"
                        : "0 ر.س",
                    style: AppStyles.font16GreenBold,
                  ),
                ],
              ),
              verticalSpace(12),
            ],
          ),
        ),
      ),
    );
  }
}