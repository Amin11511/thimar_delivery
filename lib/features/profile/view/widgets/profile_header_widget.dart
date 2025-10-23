import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar_driver/core/widgets/custom_image.dart';
import 'package:thimar_driver/features/profile/models/profile_data_model.dart';
import '../../../../core/theming/app_assets.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/theming/font_weight_helper.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/spacing.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_state.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({super.key});

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppAssets.greenBackgroundImage, height: 217.h),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.getProfileRequestState == RequestState.loading
                ? setupLoading()
                : state.getProfileRequestState == RequestState.error
                ? Container(
              height: 217.h,
              alignment: Alignment.center,
              child: Text(
                state.msg,
                style: AppStyles.font14WhiteBold.copyWith(
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            )
                : setupSuccess(state.profileDataModel!);
          },
        ),
      ],
    );
  }

  Widget setupSuccess(ProfileDataModel data) {
    return Column(
      children: [
        verticalSpace(44),
        Center(child: Text("حسابي", style: AppStyles.font16WhiteBold)),
        verticalSpace(16),
        // الصورة
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: CustomImage(
            data.data?.image ?? "",
            height: 71.h,
            width: 76.w,
            fit: BoxFit.cover,
          ),
        ),
        verticalSpace(8),
        // اسم المستخدم
        Text(data.data?.fullname ?? "", style: AppStyles.font14WhiteBold),
        verticalSpace(4),
        // رقم المستخدم
        Text(
          "+${data.data?.phone ?? ''}",
          textDirection: TextDirection.ltr,
          style: AppStyles.font14WhiteBold.copyWith(
            fontWeight: FontWeightHelper.regular,
          ),
        ),
      ],
    );
  }

  Widget setupLoading() {
    return Column(
      children: [
        verticalSpace(44),
        Center(
          child: Container(height: 20.h, width: 60.w, color: Colors.white),
        ),
        verticalSpace(16),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 71.h,
            width: 76.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
        verticalSpace(8),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: 14.h, width: 100.w, color: Colors.white),
        ),
        verticalSpace(4),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: 14.h, width: 80.w, color: Colors.white),
        ),
      ],
    );
  }
}