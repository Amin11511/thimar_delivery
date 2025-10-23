import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/routing/app_routes_fun.dart';
import 'package:thimar_driver/core/routing/routes.dart';
import 'package:thimar_driver/features/profile/view/widgets/profile_custom_row_widget.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/theming/app_assets.dart';
import '../../../../core/theming/app_color.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_custom_botton.dart';
import '../../../auth/login/cubit/login_cubit.dart';
import '../../../auth/login/cubit/login_state.dart';
import '../../cubit/profile_cubit.dart';

class ProfileListWidget extends StatefulWidget {
  final ProfileCubit profileCubit;

  const ProfileListWidget({super.key, required this.profileCubit});

  @override
  State<ProfileListWidget> createState() => _ProfileListWidgetState();
}

class _ProfileListWidgetState extends State<ProfileListWidget> {
  @override
  Widget build(BuildContext context) {
    final loginCubit = sl<LoginCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ProfileCustomRowWidget(
            title: "البيانات الشخصية",
            iconPath: AppAssets.profileUserImage,
            onTap: () {
              push(
                NamedRoutes.profileEditDataView,
                arg: widget.profileCubit,
              ).then((_) {
                // widget.profileCubit.updateProfile();
                setState(() {});
              });
            },
          ),
          ProfileCustomRowWidget(
            title: "عن التطبيق",
            iconPath: AppAssets.infoImage,
            onTap: () {
              push(NamedRoutes.aboutAppView);
            },
          ),
          ProfileCustomRowWidget(
            title: "أسئلة متكررة",
            iconPath: AppAssets.questionImage,
            onTap: () {
              push(NamedRoutes.fqsView);
            },
          ),
          ProfileCustomRowWidget(
            title: "سياسة الخصوصية",
            iconPath: AppAssets.checkImage,
            onTap: () {
              push(NamedRoutes.termsView);
            },
          ),
          ProfileCustomRowWidget(
            title: "تواصل معنا",
            iconPath: AppAssets.callingImage,
            onTap: () {
              push(NamedRoutes.contactView);
            },
          ),
          ProfileCustomRowWidget(
            title: "الشكاوي والأقتراحات",
            iconPath: AppAssets.editImage,
            onTap: () {
              push(NamedRoutes.complainView);
            },
          ),
          Divider(color: AppColors.lightGrayColor),
          verticalSpace(16),
          ProfileCustomRowWidget(
            title: "تسجيل الخروج",
            iconPath: AppAssets.starImage,
            isHasIcon: false,
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.whiteColor,
                builder: (_) {
                  return Container(
                    height: 200.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(16),
                        Center(
                          child: Text(
                            "هل أنت متأكد من تسجيل الخروج؟",
                            style: AppStyles.font16BlackBold,
                          ),
                        ),
                        verticalSpace(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: AppCustomButton(
                                textButton: "إلغاء",
                                isBorder: true,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            horizontalSpace(8),
                            BlocProvider.value(
                              value: loginCubit,
                              child: BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  final cubit = sl<LoginCubit>();
                                  return Expanded(
                                    child: AppCustomButton(
                                      isLoading:
                                      state.logoutState ==
                                          RequestState.loading,
                                      textButton: "تأكيد",
                                      backgroundColor: Colors.red,
                                      onPressed: () {
                                        cubit.logout();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            changeArrow: AppAssets.logoutImage,
          ),
        ],
      ),
    );
  }
}