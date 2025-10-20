// import 'dart:io';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:thimar_driver/core/theming/app_colors.dart';
// import 'package:thimar_driver/core/theming/app_styles.dart';
// import 'package:thimar_driver/core/utils/spacing.dart';
//
// import '../../../../../core/theming/app_assets.dart';
// import '../../../../../core/theming/font_weight_helper.dart';
//
// class ImagePickerItemWidget extends StatelessWidget {
//   final String title;
//   final File? image;
//   final Function(File file) onImageSelected;
//
//   const ImagePickerItemWidget({
//     super.key,
//     required this.title,
//     required this.onImageSelected,
//     this.image,
//   });
//
//   Future<void> _pickImage(BuildContext context) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//
//     if (picked != null) {
//       onImageSelected(File(picked.path));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _pickImage(context),
//       child: Column(
//         children: [
//           DottedBorder(
//             borderType: BorderType.RRect,
//             radius: Radius.circular(16.r),
//             dashPattern: const [6, 4],
//             color: AppColors.primaryColor,
//             strokeWidth: 1.w,
//             padding: EdgeInsets.all(6.r),
//             child: Container(
//               width: 80.w,
//               height: 80.h,
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               child: image == null
//                   ? Center(
//                       child: Image.asset(
//                         AppAssets.cameraIcon,
//                         width: 30.w,
//                         height: 30.h,
//                         fit: BoxFit.contain,
//                       ),
//                     )
//                   : ClipRRect(
//                       borderRadius: BorderRadius.circular(16.r),
//                       child: Image.file(
//                         image!,
//                         width: 90.w,
//                         height: 90.h,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//             ),
//           ),
//           verticalSpace(8),
//           Text(
//             title,
//             style: AppStyles.font16GreenMedium.copyWith(
//               fontWeight: FontWeightHelper.regular,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/core/theming/app_styles.dart';
import 'package:thimar_driver/core/utils/spacing.dart';
import '../../../../../core/theming/app_assets.dart';
import '../../../../../core/theming/app_color.dart';
import '../../../../../core/theming/font_weight_helper.dart';

class ImagePickerItemWidget extends StatelessWidget {
  final String title;
  final XFile? image;
  final Function(XFile file) onImageSelected;

  const ImagePickerItemWidget({
    super.key,
    required this.title,
    required this.onImageSelected,
    this.image,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();

    // show bottom sheet to choose source
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("اختر مصدر الصورة", style: AppStyles.font16GreenMedium),
              verticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera button
                  _buildOption(
                    icon: Icons.camera_alt_outlined,
                    label: "الكاميرا",
                    onTap: () async {
                      Navigator.pop(context);
                      final picked = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (picked != null) {
                        onImageSelected(XFile(picked.path));
                      }
                    },
                  ),
                  // Gallery button
                  _buildOption(
                    icon: Icons.photo_outlined,
                    label: "المعرض",
                    onTap: () async {
                      Navigator.pop(context);
                      final picked = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (picked != null) {
                        onImageSelected(XFile(picked.path));
                      }
                    },
                  ),
                ],
              ),
              verticalSpace(12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            child: Icon(icon, size: 28.sp, color: AppColors.primaryColor),
          ),
          verticalSpace(6),
          Text(label, style: AppStyles.font14greenBold),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(16.r),
            dashPattern: const [6, 4],
            color: AppColors.primaryColor,
            strokeWidth: 1.w,
            padding: EdgeInsets.all(6.r),
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: image == null
                  ? Center(
                child: Image.asset(
                  AppAssets.cameraIcon,
                  width: 30.w,
                  height: 30.h,
                  fit: BoxFit.contain,
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.file(
                  File(image!.path ),
                  width: 90.w,
                  height: 90.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          verticalSpace(8),
          Text(
            title,
            style: AppStyles.font16GreenMedium.copyWith(
              fontWeight: FontWeightHelper.regular,
            ),
          ),
        ],
      ),
    );
  }
}