import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/about_app/models/fqs_model.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/theming/app_assets.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/theming/app_styles.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../../../core/widgets/app_loading_indicator_widget.dart';
import '../cubit/about_app_cubit.dart';
import '../cubit/about_app_state.dart';

class FqsView extends StatelessWidget {
  const FqsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AboutAppCubit>();
    return BlocProvider.value(
      value: cubit..getFqs(),
      child: Scaffold(
          appBar: AppCustomAppBar(appBarTitle: "أسئلة متكررة"),
          body: BlocBuilder<AboutAppCubit, AboutAppState>(
              builder: (context, state) {
                return state.faqState == RequestState.loading
                    ? const AppLoadingIndicatorWidget()
                    : state.faqState == RequestState.error
                    ? Center(child: Text(state.faqMsg ?? "حدث خطأ ما"))
                    : state.faqState == RequestState.done
                    ? setupSuccess(state.fqsModel!)
                    : const SizedBox();
              })),
    );
  }

  Widget setupSuccess(FqsModel data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: data.data?.length,
        itemBuilder: (context, index) {
          final faq = data.data?[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: ExpansionTile(
              title: Text(
                faq?.question ?? "",
                style: AppStyles.font16GreenBold,
              ),
              trailing: Image.asset(
                AppAssets.arrowDownImage,
                width: 25.w,
                height: 25.h,
              ),
              backgroundColor: AppColors.whiteColor,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: AppColors.lightGrayColor,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: AppColors.lightGrayColor,
                ),
              ),
              tilePadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    faq?.answer ?? "",
                    style: AppStyles.font16DarkerGrayLight,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}