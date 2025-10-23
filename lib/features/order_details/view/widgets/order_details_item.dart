import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:thimar_driver/core/widgets/custom_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/theming/app_assets.dart';
import '../../../../core/theming/app_color.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../models/order_details_model.dart';
import 'order_details_address_widget.dart';
import 'order_details_prices.dart';

class OrderDetailsItem extends StatelessWidget {
  final OrderDetailsModel data;

  const OrderDetailsItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final order = data.data;

    DateTime? orderDate = order?.date != null
        ? DateTime.tryParse(order!.date.toString())
        : null;

    String formattedDate = orderDate != null
        ? DateFormat("dd, MMMM, yyyy", "ar").format(orderDate)
        : "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(32),
        //الحالة + رقم الطلب
        Row(
          children: [
            Text("طلب #${order?.id ?? ""}", style: AppStyles.font16GreenBold),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: getStatusContainerColor(order?.status ?? ""),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                getStatusText(order?.status ?? ""),
                style: AppStyles.font12GreenBold.copyWith(
                  color: getStatusTextColor(order?.status ?? ""),
                ),
              ),
            ),
          ],
        ),
        verticalSpace(8),
        // السعر
        Row(
          children: [
            Text(formattedDate, style: AppStyles.font16DarkerGrayLight),
            Spacer(),
            Text("${order?.totalPrice} ر.س", style: AppStyles.font16GreenBold),
          ],
        ),
        Divider(color: AppColors.lightGrayColor),
        // بيانات العميل
        Row(
          children: [
            // صورة العميل
            ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: CustomImage(
                order?.clientImage ?? "",
                width: 50.w,
                height: 50.h,
                fit: BoxFit.cover,
              ),
            ),
            horizontalSpace(16),
            // الاسم + العنوان
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الاسم
                  Text(
                    order?.clientName ?? "",
                    style: AppStyles.font16GreenBold,
                  ),
                  horizontalSpace(16),
                  // العنوان
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
                          order?.location ?? "",
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
            order?.status != "pending"
                ? IconButton(
              onPressed: () async {
                final phone = order?.phone ?? "";
                final Uri telUri = Uri(scheme: 'tel', path: phone);

                if (await canLaunchUrl(telUri)) {
                  await launchUrl(telUri);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Cannot make a call")),
                  );
                }
              },
              icon: Image.asset(
                AppAssets.callContainerIcon,
                width: 30.w,
                height: 30.h,
              ),
            )
                : SizedBox.shrink(),
          ],
        ),
        Divider(color: AppColors.lightGrayColor),
        Row(
          // صور مصغرة للمنتجات
          children: [
            ...List.generate(
              (order!.images.length > 3 ? 3 : order.images.length),
                  (index) => Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CustomImage(
                    order.images[index].url,
                    width: 25.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (order.images.length > 3)
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
                      "+${order.images.length - 3}",
                      style: AppStyles.font14WhiteBold.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppAssets.arrowLeftContainerImage,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ],
        ),
        OrderDetailsAddressWidget(data: data),
        OrderDetailsPrices(data: data),
      ],
    );
  }
}