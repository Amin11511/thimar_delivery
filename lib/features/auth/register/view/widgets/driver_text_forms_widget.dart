import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/features/auth/register/cubit/register_cubit.dart';
import '../../../../../core/theming/app_assets.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/auth_phone_and_country_widget.dart';

class DriverTextFormsWidget extends StatefulWidget {
  final RegisterCubit cubit;
  final GlobalKey<FormState> formKey;

  const DriverTextFormsWidget({
    super.key,
    required this.cubit,
    required this.formKey,
  });

  @override
  State<DriverTextFormsWidget> createState() => _DriverTextFormsWidgetState();
}

class _DriverTextFormsWidgetState extends State<DriverTextFormsWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: "اسم المندوب",
            controller: widget.cubit.nameController,
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل اسم مستخدم صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.personIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AuthPhoneAndCountryWidget(
            phoneController: widget.cubit.phoneController,
          ),
          verticalSpace(16),
          AppTextFormField(
            hintText: "المدينة",
            controller: widget.cubit.cityController,
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل مدينة صحيحة";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.flagImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            controller: widget.cubit.identityNumberController,
            hintText: "رقم الهوية",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل رقم هوية صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.userGrayIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            controller: widget.cubit.locationController,
            hintText: "تحديد الموقع على الخريطة",
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل موقع صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.locationGrayIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            controller: widget.cubit.emailController,
            hintText: "البريد الالكتروني",
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل بريد إلكتروني صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.emailGrayIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            controller: widget.cubit.passwordController,
            hintText: "كلمة المرور",
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل كلمة مرور صحيحة";
              }
              if (value.length < 6) {
                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.lockImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            controller: widget.cubit.passwordConfirmationController,
            hintText: "كلمة المرور",
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل كلمة مرور صحيحة";
              }
              if (value != widget.cubit.passwordController.text) {
                return "كلمة المرور غير متطابقة";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.lockImage,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}