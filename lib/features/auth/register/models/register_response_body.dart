import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class RegisterRequestBody {
  final String fullName;
  final String phone;
  final String cityId;
  final String lat;
  final String lng;
  final String location;
  final String identityNumber;
  final String email;
  final String password;
  final String passwordConfirmation;
  final File carLicenseImage;
  final File carFormImage;
  final File carInsuranceImage;
  final File carFrontImage;
  final File carBackImage;
  final String carType;
  final String modelId;
  final String iban;
  final String bankName;

  RegisterRequestBody({
    required this.fullName,
    required this.phone,
    required this.cityId,
    required this.lat,
    required this.lng,
    required this.location,
    required this.identityNumber,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.carLicenseImage,
    required this.carFormImage,
    required this.carInsuranceImage,
    required this.carFrontImage,
    required this.carBackImage,
    required this.carType,
    required this.modelId,
    required this.iban,
    required this.bankName,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'fullname': fullName,
      'phone': phone,
      'city_id': cityId,
      'location': location,
      'identity_number': identityNumber,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'car_type': carType,
      'model_id': modelId,
      'iban': iban,
      'bank_name': bankName,
      'lat': lat,
      'lng': lng,
      'car_license_image': await MultipartFile.fromFile(
        carLicenseImage.path,
        filename: carLicenseImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
      'car_form_image': await MultipartFile.fromFile(
        carFormImage.path,
        filename: carFormImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
      'car_insurance_image': await MultipartFile.fromFile(
        carInsuranceImage.path,
        filename: carInsuranceImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
      'car_front_image': await MultipartFile.fromFile(
        carFrontImage.path,
        filename: carFrontImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
      'car_back_image': await MultipartFile.fromFile(
        carBackImage.path,
        filename: carBackImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    });
  }

}