import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/features/profile/cubit/profile_cubit.dart';
import 'package:thimar_driver/features/profile/view/widgets/profile_header_widget.dart';
import 'package:thimar_driver/features/profile/view/widgets/profile_list_widget.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/spacing.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = sl<ProfileCubit>();
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider.value(
              value: profileCubit..getProfileData(),
              child: ProfileHeaderWidget(),
            ),
            verticalSpace(34),
            ProfileListWidget(
              profileCubit: profileCubit,
            ),
          ],
        ),
      ),
    );
  }
}