class LoginRequestBody {
  final String phone;
  final String password;
  final String device_token;
  final String type;
  final String user_type;

  LoginRequestBody({
    required this.phone,
    required this.password,
    required this.device_token,
    required this.type,
    required this.user_type,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'device_token': device_token,
      'type': type,
      'user_type': user_type,
    };
  }
}