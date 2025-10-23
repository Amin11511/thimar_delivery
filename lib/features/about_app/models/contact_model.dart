class ContactModel  {
  final ContactData? data;
  final String? status;
  final String? message;

  ContactModel({this.data, this.status, this.message});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      data: json['data'] != null ? ContactData.fromJson(json['data']) : null,
      status: json['status'] as String?,
      message: json['message'] as String?,
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

class ContactData {
  final String? phone;
  final String? email;
  final String? whatsapp;
  final Social? social;
  final double? lat;
  final double? lng;
  final String? location;

  ContactData({
    this.phone,
    this.email,
    this.whatsapp,
    this.social,
    this.lat,
    this.lng,
    this.location,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      whatsapp: json['whatsapp'] as String?,
      social: json['social'] != null ? Social.fromJson(json['social']) : null,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'whatsapp': whatsapp,
      'social': social?.toJson(),
      'lat': lat,
      'lng': lng,
      'location': location,
    };
  }
}

class Social {
  final String? facebook;
  final String? twitter;
  final String? instagram;

  Social({this.facebook, this.twitter, this.instagram});

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
    };
  }
}