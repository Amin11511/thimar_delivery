import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_color.dart';
import '../theming/app_styles.dart';

class AppCustomQuantityWidget extends StatefulWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final double? height;
  final double? buttonHeight;
  final double? buttonWidth;

  const AppCustomQuantityWidget(
      {super.key,
        required this.quantity,
        required this.onQuantityChanged,
        this.height,
        this.buttonHeight,
        this.buttonWidth});

  @override
  State<AppCustomQuantityWidget> createState() =>
      _AppCustomQuantityWidgetState();
}

class _AppCustomQuantityWidgetState extends State<AppCustomQuantityWidget> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      _quantity = newQuantity;
    });
    widget.onQuantityChanged(_quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 35.h,
      decoration: BoxDecoration(
        color: AppColors.lighterGreenColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: IconButton(
              color: AppColors.whiteColor,
              padding: EdgeInsets.zero,
              style: ButtonStyle(
                backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.whiteColor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  _updateQuantity(_quantity + 1);
                });
              },
              icon: Icon(
                Icons.add,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Text(
            _quantity.toString(),
            style: AppStyles.font16GreenMedium,
          ),
          Padding(
            padding: EdgeInsets.all(4.w),
            child: IconButton(
              color: AppColors.whiteColor,
              padding: EdgeInsets.zero,
              style: ButtonStyle(
                backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.whiteColor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  if (_quantity > 1) {
                    _updateQuantity(_quantity - 1);
                  }
                });
              },
              icon: Icon(
                Icons.remove,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}