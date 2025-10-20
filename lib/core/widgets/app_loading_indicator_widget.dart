import 'package:flutter/material.dart';
import '../theming/app_color.dart';

class AppLoadingIndicatorWidget extends StatelessWidget {
  final double? size;
  final Color? color;

  const AppLoadingIndicatorWidget({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primaryColor,
        ),
      ),
    );
  }
}