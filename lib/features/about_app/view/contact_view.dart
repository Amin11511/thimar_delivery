import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/features/about_app/view/widgets/contact_location_widget.dart';
import 'package:thimar_driver/features/about_app/view/widgets/suggetions_and_complaints_widgets.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/theming/app_styles.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/app_custom_app_bar.dart';
import '../cubit/about_app_cubit.dart';

class  ContactView extends StatelessWidget {
  const  ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AboutAppCubit>();
    return Scaffold(
      appBar: AppCustomAppBar(appBarTitle: "تواصل معنا"),
      body: SingleChildScrollView(
        child: BlocProvider.value(
          value: cubit..getContact(),
          child: Column(
            children: [
              ContactLocationWidget(),
              verticalSpace(70),
              Text(
                "أو يمكنك إرسال رسالة ",
                style: AppStyles.font16GreenBold,
              ),
              SuggestionsAndComplaintsWidgets(),
              verticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }
}