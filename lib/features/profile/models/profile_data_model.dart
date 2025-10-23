import '../../auth/login/models/base.dart';

class ProfileDataModel extends Model {
  final Data? data;
  final String? status;
  final String? message;

  ProfileDataModel({
    this.data,
    this.status,
    this.message,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'status': status,
      'message': message,
    };
  }
}

class Data {
  final int? id;
  final String? image;
  final String? fullname;
  final String? phone;
  final int? cityId;
  final String? identityNumber;
  final String? iban;
  final String? bankName;
  final String? carLicenceImage;
  final String? carFormImage;
  final String? carInsuranceImage;
  final String? carFrontImage;
  final String? carBackImage;
  final String? carType;
  final CarModel? carModel;

  Data({
    this.id,
    this.image,
    this.fullname,
    this.phone,
    this.cityId,
    this.identityNumber,
    this.iban,
    this.bankName,
    this.carLicenceImage,
    this.carFormImage,
    this.carInsuranceImage,
    this.carFrontImage,
    this.carBackImage,
    this.carType,
    this.carModel,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      image: json['image'],
      fullname: json['fullname'],
      phone: json['phone'],
      cityId: json['city_id'],
      identityNumber: json['identity_number'],
      iban: json['iban'],
      bankName: json['bank_name'],
      carLicenceImage: json['car_licence_image'],
      carFormImage: json['car_form_image'],
      carInsuranceImage: json['car_insurance_image'],
      carFrontImage: json['car_front_image'],
      carBackImage: json['car_back_image'],
      carType: json['car_type'],
      carModel: json['car_model'] != null ? CarModel.fromJson(json['car_model']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'fullname': fullname,
      'phone': phone,
      'city_id': cityId,
      'identity_number': identityNumber,
      'iban': iban,
      'bank_name': bankName,
      'car_licence_image': carLicenceImage,
      'car_form_image': carFormImage,
      'car_insurance_image': carInsuranceImage,
      'car_front_image': carFrontImage,
      'car_back_image': carBackImage,
      'car_type': carType,
      'car_model': carModel?.toJson(),
    };
  }
}

class CarModel {
  final int? id;
  final String? name;
  final int? brandId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CarModel({
    this.id,
    this.name,
    this.brandId,
    this.createdAt,
    this.updatedAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      name: json['name'],
      brandId: json['brand_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand_id': brandId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}