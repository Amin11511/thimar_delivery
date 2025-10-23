import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/about_app/models/terms_model.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../cubit/about_app_cubit.dart';
import '../cubit/about_app_state.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AboutAppCubit>();
    return BlocProvider.value(
      value: cubit..getTerms(),
      child: Scaffold(
        appBar: AppCustomAppBar(appBarTitle: "سياسة الخصوصية"),
        body: BlocBuilder<AboutAppCubit, AboutAppState>(
          builder: (context, state) {
            return state.termsState == RequestState.loading
                ? const Center(child: CircularProgressIndicator())
                : state.termsState == RequestState.error
                ? Center(child: Text(state.termsMsg))
                : setupSuccess(state.termsModel!);
          },
        ),
      ),
    );
  }

  Widget setupSuccess(TermsModel data) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: SingleChildScrollView(
        child: Html(
          data: data.policy ?? "",
        ),
      ),
    );
  }
}