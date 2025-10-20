import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../theming/app_color.dart';
import 'image_picker_services.dart';

class SelectSingleImageWidget extends StatelessWidget {
  final cubit;
  final XFile? image;
  final Function(XFile) updateImageCallback;

  const SelectSingleImageWidget({
    super.key,
    required this.cubit,
    required this.image,
    required this.updateImageCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          backgroundColor: AppColors.whiteColor,
          context: context,
          builder: (context) {
            return SizedBox(
              height: 150.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: Text("Camera"),
                    onTap: () async {
                      Navigator.pop(context);
                      final imagePickerService = ImagePickerService();
                      final pickedImage = await imagePickerService.pickImage(
                        source: ImageSource.camera,
                      );
                      if (pickedImage != null) {
                        updateImageCallback(pickedImage);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text("Gallery"),
                    onTap: () async {
                      Navigator.pop(context);
                      final imagePickerService = ImagePickerService();
                      final pickedImage = await imagePickerService.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedImage != null) {
                        updateImageCallback(pickedImage);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: MediaQuery.sizeOf(context).width - 48.w,
        child: Center(
          child: image != null
              ? Image.file(
            File(image!.path),
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   AppAssets.uploadImageIcon,
              //   width: 64.w,
              //   height: 64.h,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}