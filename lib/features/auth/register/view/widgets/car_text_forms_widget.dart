import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/core/theming/app_styles.dart';
import 'package:thimar_driver/core/utils/spacing.dart';
import 'package:thimar_driver/core/widgets/app_text_form_field.dart';
import '../../../../../core/theming/app_assets.dart';
import '../../../../../core/theming/app_color.dart';
import '../../cubit/register_cubit.dart';
import 'item_picker_image_widget.dart';

class CarTextFormsWidget extends StatefulWidget {
  final RegisterCubit cubit;
  final GlobalKey<FormState> formKey;

  const CarTextFormsWidget({
    super.key,
    required this.cubit,
    required this.formKey,
  });

  @override
  State<CarTextFormsWidget> createState() => _CarTextFormsWidgetState();
}

class _CarTextFormsWidgetState extends State<CarTextFormsWidget>
    with AutomaticKeepAliveClientMixin {
  XFile? selectLicenseImage;
  XFile? selectFormImage;
  XFile? selectPayImage;
  XFile? selectFrontCarImage;
  XFile? selectBackCarImage;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            alignment: WrapAlignment.center,
            children: [
              ImagePickerItemWidget(
                title: "رخصة القيادة",
                image: selectLicenseImage,
                onImageSelected: (file) {
                  setState(() => selectLicenseImage = file);
                  widget.cubit.carLicenseImage = file;
                },
              ),
              ImagePickerItemWidget(
                title: "استمارة السيارة",
                image: selectFormImage,
                onImageSelected: (file) {
                  setState(() => selectFormImage = file);
                  widget.cubit.carFormImage = file;
                },
              ),
              ImagePickerItemWidget(
                title: "تأمين السيارة",
                image: selectPayImage,
                onImageSelected: (file) {
                  setState(() => selectPayImage = file);
                  widget.cubit.carInsuranceImage = file;
                },
              ),
              ImagePickerItemWidget(
                title: "السيارة من الأمام",
                image: selectFrontCarImage,
                onImageSelected: (file) {
                  setState(() => selectFrontCarImage = file);
                  widget.cubit.carFrontImage = file;
                },
              ),
              ImagePickerItemWidget(
                title: "السيارة من الخلف",
                image: selectBackCarImage,
                onImageSelected: (file) {
                  setState(() => selectBackCarImage = file);
                  widget.cubit.carBackImage = file;
                },
              ),
            ],
          ),
          verticalSpace(16),
          AppTextFormField(
            hintText: "نوع السيارة",
            controller: widget.cubit.carTypeController,
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل نوع سيارة صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.carIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            hintText: "موديل السيارة",
            controller: widget.cubit.modelIdController,
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل موديل سيارة صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.carIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),

          AppTextFormField(
            hintText: "رقم الإيبان",
            controller: widget.cubit.ibanController,
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل رقم إيبان صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.dollarGrayIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),
          AppTextFormField(
            hintText: "إسم البنك",
            controller: widget.cubit.bankNameController,
            validator: (value) {
              if (value.isEmpty) {
                return "أدخل إسم بنك صحيح";
              }
              return null;
            },
            prefixIcon: Image.asset(
              AppAssets.bankIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          verticalSpace(16),

          Row(
            children: [
              Checkbox(
                value: true,
                fillColor: WidgetStateProperty.all(AppColors.primaryColor),
                onChanged: (value) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "الموافقة على الشروط والأحكام",
                  style: AppStyles.font14greenBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}