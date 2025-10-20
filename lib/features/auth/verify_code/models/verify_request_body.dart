class VerifiRequestBody {
  final String phone;
  final String code;
  final String? deviceToken;
  final String? type;

  VerifiRequestBody({
    required this.phone,
    required this.code,
    this.deviceToken,
    this.type,
  });
  Map<String, dynamic> toJson() => {
    "phone": phone,
    "code": code,
    "device_token": deviceToken,
    "type": type,
  };
}