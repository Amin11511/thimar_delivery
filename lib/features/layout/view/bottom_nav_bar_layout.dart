import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/theming/app_styles.dart';
import '../../../core/utils/spacing.dart';
import '../cubit/bottom_nav_bar_cubit.dart';
import '../cubit/bottom_nav_bar_state.dart';

class BottomNavBarLayout extends StatelessWidget {
  final int? initialIndex;

  const BottomNavBarLayout({super.key, this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit()..changeIndex(initialIndex ?? 0),
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          final bottomNavCubit = context.read<BottomNavBarCubit>();

          return Scaffold(
            body: bottomNavCubit.bottomNavScreens[bottomNavCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.primaryColor,
              currentIndex: bottomNavCubit.currentIndex,
              iconSize: 25.r,
              selectedFontSize: 16.sp,
              unselectedFontSize: 16.sp,
              unselectedIconTheme: IconThemeData(size: 25.r),
              selectedIconTheme: IconThemeData(
                color: AppColors.whiteColor,
                size: 25.r,
              ),
              selectedItemColor: Colors.white,
              selectedLabelStyle: AppStyles.font16WhiteBold,
              unselectedLabelStyle: AppStyles.font16WhiteBold.copyWith(
                color: AppColors.lightGreenColor,
              ),
              unselectedItemColor: AppColors.lightGreenColor,
              enableFeedback: true,
              onTap: (index) {
                bottomNavCubit.changeIndex(index);
              },
              items: List.generate(
                bottomNavCubit.selectedIcons.length,
                    (index) => BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      verticalSpace(8),
                      Image.asset(
                        bottomNavCubit.unSelectedIcons[index],
                        color: AppColors.lightGreenColor,
                        width: 25,
                        height: 25,
                      ),
                      verticalSpace(6),
                    ],
                  ),
                  activeIcon: Column(
                    children: [
                      verticalSpace(8),
                      Image.asset(
                        bottomNavCubit.selectedIcons[index],
                        color: AppColors.whiteColor,
                        width: 25,
                        height: 25,
                      ),
                      verticalSpace(6),
                    ],
                  ),
                  label: bottomNavCubit.labels[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}