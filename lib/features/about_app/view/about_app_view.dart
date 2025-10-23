import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/about_app/models/about_app_model.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/theming/app_assets.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../cubit/about_app_cubit.dart';
import '../cubit/about_app_state.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AboutAppCubit>();

    return BlocProvider.value(
      value: cubit..getAboutApp(),
      child: Scaffold(
        appBar: AppCustomAppBar(appBarTitle: "عن التطبيق"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(30),
                Center(
                  child: Image.asset(
                    AppAssets.thimarIcon,
                    height: 160.h,
                    width: 160.w,
                  ),
                ),
                verticalSpace(16),
                BlocBuilder<AboutAppCubit, AboutAppState>(
                  builder: (context, state) {
                    return state.getAboutAppState == RequestState.loading
                        ? const Center(child: CircularProgressIndicator())
                        : state.getAboutAppState == RequestState.error
                        ? Center(child: Text(state.aboutAppMsg ?? "حدث خطأ ما"))
                        : setupSuccess(state.aboutAppModel!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setupSuccess(AboutAppModel data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Html(
        data: data.about,
        style: {
          "p.fancy": Style(
            textAlign: TextAlign.center,
            backgroundColor: Colors.grey,
            margin: Margins(left: Margin(50, Unit.px), right: Margin.auto()),
            width: Width(300, Unit.px),
            fontWeight: FontWeight.bold,
          ),
        },
      ),
    );
  }
}