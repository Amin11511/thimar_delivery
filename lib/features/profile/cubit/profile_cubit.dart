import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/utils/enums.dart';
import 'package:thimar_driver/core/widgets/flash_helper.dart';
import 'package:thimar_driver/features/profile/cubit/profile_state.dart';
import 'package:thimar_driver/features/profile/models/profile_data_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final bankController = TextEditingController();
  final identityNumberController = TextEditingController();
  XFile? carFrontImage;
  XFile? carBackImage;
  XFile? carLicenseImage;
  XFile? carFormImage;
  XFile? carInsuranceImage;
  final carTypeController = TextEditingController();
  final ibanController = TextEditingController();
  final carModelController = TextEditingController();
  XFile? personalImage;

  Future<void> getProfileData() async {
    emit(state.copyWith(getProfileRequestState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getProfileEP,
    );
    if (result.success) {
      final model = ProfileDataModel.fromJson(result.data);
      emit(
        state.copyWith(
          getProfileRequestState: RequestState.done,
          profileDataModel: model,
        ),
      );
    } else {
      FlashHelper.showToast(result.msg);
      emit(
        state.copyWith(
          getProfileRequestState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
        ),
      );
    }
  }

  Future<void> updateProfile() async {
    emit(state.copyWith(updateProfileRequestState: RequestState.loading));
    final formData = {
      'fullname': nameController.text,
      'phone': phoneController.text,
      'city_id': "12",
      'identity_number': identityNumberController.text,
      'car_type': carTypeController.text,
      'model_id': "3",
      'iban': ibanController.text,
      'bank_name': bankController.text,
      if (carLicenseImage != null)
        'car_licence_image': MultipartFile.fromFileSync(carLicenseImage!.path),
      if (carFormImage != null)
        'car_form_image': MultipartFile.fromFileSync(carFormImage!.path),
      if (carInsuranceImage != null)
        'car_insurance_image': MultipartFile.fromFileSync(
          carInsuranceImage!.path,
        ),
      if (carFrontImage != null)
        'car_front_image': MultipartFile.fromFileSync(carFrontImage!.path),
      if (carBackImage != null)
        'car_back_image': MultipartFile.fromFileSync(carBackImage!.path),
      'lat': '30.033333',
      'lng': '31.233334',
      if (personalImage != null)
        'image': MultipartFile.fromFileSync(personalImage!.path),
    };

    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.getProfileEP,
      formData: formData,
      headers: {'Accept': 'application/json'},
    );
    if (result.success) {
      FlashHelper.showToast(result.msg);
      emit(
        state.copyWith(
          updateProfileRequestState: RequestState.done,
          msg: result.msg,
        ),
      );
      await getProfileData();
    } else {
      FlashHelper.showToast(result.msg);
      emit(
        state.copyWith(
          updateProfileRequestState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
        ),
      );
    }
  }
  void updateSelectedImages(XFile newImage) {
    personalImage = newImage;
    emit(state.copyWith());
  }
}