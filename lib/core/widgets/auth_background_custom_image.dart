import 'package:flutter/material.dart';
import '../theming/app_assets.dart';

class AuthBackgroundCustomImage extends StatelessWidget {
  final Widget child;

  const AuthBackgroundCustomImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}