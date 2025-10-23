import '../../auth/login/models/base.dart';

class UpdateProfileModel extends Model {
  final UserData? data;
  final String? status;
  final String? message;

  UpdateProfileModel({
    this.data,
    this.status,
    this.message,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      status: json['status'],
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'status': status,
      'message': message,
    };
  }
}

class UserData extends Model {
  final int? userId;
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

  UserData({
    this.userId,
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

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['id'],
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

class CarModel extends Model {
  final int? carId;
  final String? name;
  final int? brandId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CarModel({
    this.carId,
    this.name,
    this.brandId,
    this.createdAt,
    this.updatedAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      carId: json['id'],
      name: json['name'],
      brandId: json['brand_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  @override
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