import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/widgets/app_loading_indicator_widget.dart';
import 'package:thimar_driver/features/notifications/cubit/notifications_cubit.dart';
import 'package:thimar_driver/features/notifications/cubit/notifications_state.dart';
import 'package:thimar_driver/features/notifications/models/notifications_response_model.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/theming/app_assets.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/theming/app_styles.dart';
import '../../../core/theming/font_weight_helper.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/app_custom_app_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final notificationCubit = sl<NotificationsCubit>();

  @override
  void initState() {
    super.initState();
    notificationCubit.loadNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        appBarTitle: "الإشعارات",
        isHaveBackButton: false,
      ),
      body: BlocProvider.value(
        value: notificationCubit,
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return state.requestState.isLoading
                ? AppLoadingIndicatorWidget()
                : state.requestState.isError
                ? Center(child: Text(state.errorMessage ))
                : setupSuccess(state.notifications!);
          },
        ),
      ),
    );
  }

  Widget setupSuccess(NotificationResponseModel data) {
    final notifications = data.data.notifications;
    if (notifications == null || notifications.isEmpty) {
      return ListView(
        children: [
          SizedBox(height: 200.h),
          Center(
            child: Text("لا توجد إشعارات", style: AppStyles.font16BlackBold),
          ),
        ],
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.data.notifications.length,
            shrinkWrap: true,
            controller: notificationCubit.scrollController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h,left: 16.w,right: 16.w,top: index==0?16.h:0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // اللوجو
                        Image.asset(
                          AppAssets.thimarIcon,
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.contain,
                        ),
                        horizontalSpace(8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notifications[index].title,
                                style: AppStyles.font16BlackBold,
                              ),
                              verticalSpace(8),
                              Text(
                                notifications[index].title ,
                                style: AppStyles.font14WhiteBold.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeightHelper.regular,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace(8),
                              Text(
                                notifications[index].createdAt,
                                style: AppStyles.font14greenBold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (BuildContext context, state) {
            if (state.isLoadingMore == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}