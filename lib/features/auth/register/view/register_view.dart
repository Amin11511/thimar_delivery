import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/utils/spacing.dart';
import 'package:thimar_driver/core/widgets/auth_background_custom_image.dart';
import 'package:thimar_driver/core/widgets/auth_header_widget.dart';
import 'package:thimar_driver/features/auth/register/cubit/register_cubit.dart';
import 'package:thimar_driver/features/auth/register/view/widgets/car_text_forms_widget.dart';
import 'package:thimar_driver/features/auth/register/view/widgets/driver_text_forms_widget.dart';
import 'package:thimar_driver/features/auth/register/view/widgets/register_buttons_widget.dart';
import 'package:thimar_driver/features/auth/register/view/widgets/register_steps_widget.dart';

import '../../../../core/routing/app_routes_fun.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/service_locator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final PageController _pageController;
  int currentPage = 0;

  final GlobalKey<FormState> _driverFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _carFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextStep(RegisterCubit cubit) {
    if (currentPage == 0) {
      if (_driverFormKey.currentState?.validate() ?? false) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        setState(() => currentPage = 1);
        cubit.changePageIndex(1);
      }
    } else {
      if (_carFormKey.currentState?.validate() ?? false) {
        cubit.register().then((_) {
          push(
            NamedRoutes.verifiedView,
            arg: {'phone': cubit.phoneController.text, 'isActiveAccount': true},
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<RegisterCubit>();
          return Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: RegisterButtonsWidget(
                currentStep: currentPage,
                onTap: () => _goToNextStep(cubit),
                onBack: () {
                  if (currentPage == 1) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                    setState(() => currentPage = 0);
                    cubit.changePageIndex(0);
                  }
                },
              ),
            ),
            body: SafeArea(
              child: AuthBackgroundCustomImage(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: const AuthHeaderWidget(),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(16),
                              RegisterStepsWidget(currentPage: currentPage),
                              verticalSpace(16),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      allowImplicitScrolling: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SingleChildScrollView(
                          child: DriverTextFormsWidget(
                            cubit: cubit,
                            formKey: _driverFormKey,
                          ),
                        ),
                        SingleChildScrollView(
                          child: CarTextFormsWidget(
                            cubit: cubit,
                            formKey: _carFormKey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}