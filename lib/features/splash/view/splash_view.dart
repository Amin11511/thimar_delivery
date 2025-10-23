import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import '../../../core/theming/app_assets.dart';
import '../../../core/utils/my_bloc_observer.dart';
import '../../auth/login/models/user_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    _navigate();
    logger.w(UserModel.i.isAuth);

    _requestLocationPermission();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    await UserModel.i.get();
    if (!mounted) return;

    if (UserModel.i.isAuth) {
      pushAndRemoveUntil(NamedRoutes.bottomNavBarLayout);
    } else {
      pushAndRemoveUntil(NamedRoutes.login);
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      debugPrint('✅ Location permission granted');
    } else if (status.isDenied) {
      debugPrint('❌ Location permission denied');
    } else if (status.isPermanentlyDenied) {
      debugPrint('🚫 Permission permanently denied. Opening settings...');
      await openAppSettings();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.backgroundImage, fit: BoxFit.fill),
          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: Image.asset(
                AppAssets.thimarIcon,
                width: 160.w,
                height: 157.h,
              ),
            ),
          ),
          Positioned(
            bottom: -25.h,
            right: -140.w,
            child: Image.asset(
              AppAssets.vegetablesBagIcon,
              width: 448.w,
              height: 298.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}