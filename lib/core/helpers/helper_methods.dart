import 'package:animated_confirm_dialog/animated_confirm_dialog.dart';
import 'package:flutter/material.dart';
import '../theming/app_color.dart';

appCustomDialog({
  required BuildContext context,
  String? title,
  String? message,
  required void Function() onConfirmPress,
}) {
  showCustomDialog(
    context: context,
    title: title ?? "تنبيه",
    message: message ?? "هل أنت متأكد من حذف هذا العنصر من السلة؟",
    cancelButtonText: "لا",
    confirmButtonText: "نعم",
    cancelButtonColor: Colors.red,
    cancelButtonTextColor: Colors.white,
    confirmButtonColor: AppColors.primaryColor,
    confirmButtonTextColor: Colors.white,
    onCancel: () {
      Navigator.of(context).pop();
    },
    onConfirm: onConfirmPress,
    isFlip: false,
  );
}

Color getStatusContainerColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'accepted':
      return AppColors.yellowGreenColor;
    case 'in_way':
      return AppColors.lightBlueGreenColor;
    case 'delivered':
      return AppColors.lightGrayColor;
    case 'pending':
      return AppColors.lighterGreenColor;
    case 'canceled':
      return AppColors.lightRedColor;
    default:
      return AppColors.lighterGreenColor;
  }
}

String getStatusText(String? status) {
  switch (status?.toLowerCase()) {
    case 'accepted':
      return "جاري التحضير";
    case 'in_way':
      return "في الطريق";
    case 'delivered':
      return "منتهي";
    case 'canceled':
      return "طلب ملغي";
    case 'pending':
      return "بإنتظار الموافقة";
    default:
      return "بإنتظار الموافقة";
  }
}

Color getStatusTextColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'accepted':
      return AppColors.primaryColor;
    case 'in_way':
      return AppColors.blueGreenColor;
    case 'delivered':
      return AppColors.darkerGrayColor;
    case 'pending':
      return AppColors.primaryColor;
    case 'canceled':
      return AppColors.redColor;
    default:
      return AppColors.blackColor;
  }
}