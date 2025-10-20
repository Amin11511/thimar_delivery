import 'dart:convert';
import '../../../../main.dart';
import 'base.dart';

class UserModel extends Model {
  UserModel._();
  static UserModel i = UserModel._();

  late String token, fullname, image, phoneCode, phone, email, userType, locale, identityNumber;
  late bool isActive, isBan;
  int unreadNotifications = 0, userCartCount = 0;
  Map<String, dynamic>? city;

  bool get isAuth => token.isNotEmpty;

  fromJson([Map<String, dynamic>? json]) {
    if (json == null) {
      id = '';
      token = '';
      fullname = '';
      return;
    }

    final data = json['data'] ?? {};

    id = stringFromJson(data, "id");
    token = stringFromJson(data, "token");
    fullname = stringFromJson(data, "fullname");
    image = stringFromJson(data, "image");
    phoneCode = stringFromJson(data, "phone_code"); // لو موجود
    phone = stringFromJson(data, "phone");
    email = stringFromJson(data, "email");
    userType = stringFromJson(data, "user_type");
    isActive = boolFromJson(data, "is_active", defaultValue: false);
    isBan = boolFromJson(data, "is_ban", defaultValue: false);
    identityNumber = stringFromJson(data, "identity_number");
    unreadNotifications = intFromJson(data, "unread_notifications", defaultValue: 0);
    userCartCount = intFromJson(data, "user_cart_count", defaultValue: 0);
    locale = stringFromJson(data, "locale", defaultValue: 'ar');
    city = data['city'];
  }

  save() {
    Prefs.setString('user', jsonEncode(toJson()));
  }

  clear() {
    Prefs.remove('user');
    fromJson();
  }

  get() {
    final user = Prefs.getString('user');
    if (user != null && user.isNotEmpty) {
      fromJson(jsonDecode(user));
    } else {
      fromJson();
    }
  }

  @override
  Map<String, dynamic> toJson() => {
    "data": {
      "id": id,
      "token": token,
      "fullname": fullname,
      "image": image,
      "phone_code": phoneCode,
      "phone": phone,
      "email": email,
      "user_type": userType,
      "is_active": isActive,
      "is_ban": isBan,
      "identity_number": identityNumber,
      "unread_notifications": unreadNotifications,
      "user_cart_count": userCartCount,
      "locale": locale,
      "city": city,
    },
    "status": "success",
    "message": ""
  };
}