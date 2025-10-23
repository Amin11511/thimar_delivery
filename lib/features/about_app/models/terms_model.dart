import '../../auth/login/models/base.dart';

class TermsModel extends Model {
  final String? policy;
  final String? status;
  final String? message;

  TermsModel({this.policy, this.status, this.message});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      policy: json['data']?['policy'] as String?, // the API uses "about" field
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {'policy': policy},
      'status': status,
      'message': message,
    };
  }
}