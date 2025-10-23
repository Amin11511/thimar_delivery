import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/features/profile/cubit/profile_cubit.dart';

import '../../../../core/theming/app_assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../auth/register/view/widgets/item_picker_image_widget.dart';
import '../../models/profile_data_model.dart';

class EditProfileCarForm extends StatefulWidget {
  final ProfileCubit cubit;
  final ProfileDataModel data;

  const EditProfileCarForm({
    super.key,
    required this.cubit,
    required this.data,
  });

  @override
  State<EditProfileCarForm> createState() => _EditProfileCarFormState();
}

class _EditProfileCarFormState extends State<EditProfileCarForm> {
  XFile? selectLicenseImage;
  XFile? selectFormImage;
  XFile? selectPayImage;
  XFile? selectFrontCarImage;
  XFile? selectBackCarImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
            controller: widget.cubit.carTypeController
              ..text = widget.data.data?.carType ?? "",
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
            controller: widget.cubit.carModelController
              ..text = widget.data.data?.carModel?.name ?? "",
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
            controller: widget.cubit.ibanController
              ..text = widget.data.data?.iban ?? "",
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
            controller: widget.cubit.bankController
              ..text = widget.data.data?.bankName ?? "",
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
        ],
      ),
    );
  }
}