import 'package:flutter/material.dart';
import 'package:thimar_driver/features/about_app/view/widgets/suggetions_and_complaints_widgets.dart';
import '../../../core/widgets/app_custom_app_bar.dart';

class ComplainView extends StatelessWidget {
  const ComplainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppCustomAppBar(appBarTitle: "الأقتراحات والشكاوي"),
      body: SingleChildScrollView(child: SuggestionsAndComplaintsWidgets()),
    );
  }
}