class OrderDetailsModel {
  final String status;
  final String message;
  final OrderData? data;

  OrderDetailsModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
    );
  }
}

class OrderData {
  final int id;
  final String status;
  final String date;
  final String time;
  final num orderPrice;
  final num deliveryPrice;
  final num totalPrice;
  final String clientName;
  final String clientImage;
  final String? phone;
  final Address? address;
  final String? location;
  final List<OrderImage> images;
  final String payType;
  final String? note;

  OrderData({
    required this.id,
    required this.status,
    required this.date,
    required this.time,
    required this.orderPrice,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.clientName,
    required this.clientImage,
    this.phone,
    this.address,
    this.location,
    required this.images,
    required this.payType,
    this.note,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      orderPrice: json['order_price'] ?? 0,
      deliveryPrice: json['delivery_price'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
      clientName: json['client_name'] ?? '',
      clientImage: json['client_image'] ?? '',
      phone: json['phone'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      location: json['location'],
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => OrderImage.fromJson(e))
          .toList(),
      payType: json['pay_type'] ?? '',
      note: json['note'],
    );
  }
}

class Address {
  final int id;
  final String type;
  final double lat;
  final double lng;
  final String location;
  final String? description;
  final int userId;
  final int isDefault;
  final String phone;
  final String createdAt;
  final String updatedAt;

  Address({
    required this.id,
    required this.type,
    required this.lat,
    required this.lng,
    required this.location,
    this.description,
    required this.userId,
    required this.isDefault,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] ?? '',
      description: json['description'],
      userId: json['user_id'] ?? 0,
      isDefault: json['is_default'] ?? 0,
      phone: json['phone'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class OrderImage {
  final String name;
  final String url;

  OrderImage({
    required this.name,
    required this.url,
  });

  factory OrderImage.fromJson(Map<String, dynamic> json) {
    return OrderImage(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}