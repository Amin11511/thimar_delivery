

class VerifiCodeModel {
  final int? id;
  final String? fullname;
  final String? phone;
  final String? email;
  final String? image;
  final int? isBan;
  final bool? isActive;
  final int? unreadNotifications;
  final String? userType;
  final String? token;
  final String? country;
  final City? city;
  final String? identityNumber;
  final int? userCartCount;

  VerifiCodeModel({
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.image,
    this.isBan,
    this.isActive,
    this.unreadNotifications,
    this.userType,
    this.token,
    this.country,
    this.city,
    this.identityNumber,
    this.userCartCount,
  });

  factory VerifiCodeModel.fromJson(Map<String, dynamic> json) {
    return VerifiCodeModel(
      id: json['data']?['id'] as int?,
      fullname: json['data']?['fullname'] as String?,
      phone: json['data']?['phone'] as String?,
      email: json['data']?['email'] as String?,
      image: json['data']?['image'] as String?,
      isBan: json['data']?['is_ban'] as int?,
      isActive: json['data']?['is_active'] as bool?,
      unreadNotifications: json['data']?['unread_notifications'] as int?,
      userType: json['data']?['user_type'] as String?,
      token: json['data']?['token'] as String?,
      country: json['data']?['country'] as String?,
      city: json['data']?['city'] != null
          ? City.fromJson(json['data']?['city'])
          : null,
      identityNumber: json['data']?['identity_number'] as String?,
      userCartCount: json['data']?['user_cart_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'image': image,
        'is_ban': isBan,
        'is_active': isActive,
        'unread_notifications': unreadNotifications,
        'user_type': userType,
        'token': token,
        'country': country,
        'city': city?.toJson(),
        'identity_number': identityNumber,
        'user_cart_count': userCartCount,
      },
      'status': 'success',
      'message': '',
    };
  }
}

class City {
  final String? id;
  final String? name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(id: json['id'] as String?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}