class VerifyResponseModel  {
  final bool? isActive;
  final int? devMessage;
  final String? status;
  final String? message;

  VerifyResponseModel({
    this.isActive,
    this.devMessage,
    this.status,
    this.message,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      isActive: json['is_active'] as bool?,
      devMessage: json['dev_message'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'is_active': isActive,
      'dev_message': devMessage,
    };
  }
}