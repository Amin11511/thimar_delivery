import '../../auth/login/models/base.dart';

class ComplaintModel extends Model {
  final String? status;
  final dynamic data; // can be null or some future data structure
  final String? message;

  ComplaintModel({this.status, this.data, this.message});

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      status: json['status'] as String?,
      data: json['data'], // data can be null
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data,
      'message': message,
    };
  }
}
