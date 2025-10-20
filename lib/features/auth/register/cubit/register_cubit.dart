import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar_driver/core/services/api_constants.dart';
import 'package:thimar_driver/core/services/server_gate.dart';
import 'package:thimar_driver/core/utils/my_bloc_observer.dart';
import 'package:thimar_driver/core/widgets/flash_helper.dart';
import 'package:thimar_driver/features/auth/register/cubit/register_state.dart';
import '../../../../core/utils/enums.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final identityNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final locationController = TextEditingController();
  final carTypeController = TextEditingController();
  final modelIdController = TextEditingController();
  final ibanController = TextEditingController();
  final bankNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  XFile? carLicenseImage;
  XFile? carFormImage;
  XFile? carInsuranceImage;
  XFile? carFrontImage;
  XFile? carBackImage;

  Future<void> register() async {
    emit(state.copyWith(registerState: RequestState.loading));

    if (carLicenseImage == null ||
        carFormImage == null ||
        carInsuranceImage == null ||
        carFrontImage == null ||
        carBackImage == null) {
      FlashHelper.showToast("يرجى اختيار كل الصور المطلوبة قبل التسجيل");
      emit(state.copyWith(registerState: RequestState.error));
      return;
    }

    final formData = {
      'fullname': nameController.text,
      'phone': phoneController.text,
      'city_id': "12",
      'location': locationController.text,
      'identity_number': identityNumberController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmationController.text,
      'car_type': carTypeController.text,
      'model_id': "3",
      'iban': ibanController.text,
      'bank_name': bankNameController.text,
      'car_licence_image': MultipartFile.fromFileSync(carLicenseImage!.path),
      'car_form_image': MultipartFile.fromFileSync(carFormImage!.path),
      'car_insurance_image': MultipartFile.fromFileSync(
        carInsuranceImage!.path,
      ),
      'car_front_image': MultipartFile.fromFileSync(carFrontImage!.path),
      'car_back_image': MultipartFile.fromFileSync(carBackImage!.path),
      'lat': '30.033333',
      'lng': '31.233334',
    };

    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.registerEp,
      formData: formData,
      headers: {'Accept': 'application/json'},
    );

    logger.d(result.msg);

    if (result.success) {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(registerState: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(
        state.copyWith(
          registerState: RequestState.error,
          msg: result.msg,
          errorType: result.errType,
        ),
      );
    }
  }

  void changePageIndex(int index) {
    emit(state.copyWith(registerState: RequestState.done));
  }
}