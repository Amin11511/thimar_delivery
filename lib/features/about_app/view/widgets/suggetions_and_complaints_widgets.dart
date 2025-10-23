import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/app_custom_botton.dart';
import '../../cubit/about_app_cubit.dart';
import '../../cubit/about_app_state.dart';

class SuggestionsAndComplaintsWidgets extends StatelessWidget {
  const SuggestionsAndComplaintsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AboutAppCubit>();
    return BlocProvider.value(
      value: cubit,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              verticalSpace(40),
              AppTextFormField(
                hintText: "الإسم",
                controller: cubit.nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                },
              ),
              verticalSpace(10),
              AppTextFormField(
                hintText: "رقم الموبايل",
                controller: cubit.phoneController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                },
              ),
              verticalSpace(10),
              AppTextFormField(
                hintText: "عنوان المشكلة",
                controller: cubit.titleController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                },
              ),
              verticalSpace(10),
              AppTextFormField(
                hintText: "الموضوع",
                controller: cubit.contentController,
                maxLines: 5,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                },
              ),
              verticalSpace(30),
              BlocBuilder<AboutAppCubit, AboutAppState>(
                builder: (context, state) {
                  return AppCustomButton(
                    isLoading: state.complainState == RequestState.loading,
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.sendComplaints();
                      }
                    },
                    textButton: "إرسال",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}