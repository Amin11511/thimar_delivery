import 'package:thimar_driver/features/auth/login/models/base.dart';

class CurrentOrdersModel extends Model {
  List<CurrentOrderData> data = [];
  late final Links links;
  late final Meta meta;
  late final String status;
  late final String message;

  CurrentOrdersModel.fromJson([Map<String, dynamic>? json]) {
    if (json?['data'] != null) {
      data = <CurrentOrderData>[];
      json?['data'].forEach((v) {
        data.add(CurrentOrderData.fromJson(v));
      });
    }
    links = Links.fromJson(json?['links']);
    meta = Meta.fromJson(json?['meta']);
    status = stringFromJson(json, "status");
    message = stringFromJson(json, "message");
  }

  @override
  Map<String, dynamic> toJson() => {
    "data": data.map((v) => v.toJson()).toList(),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "status": status,
    "message": message,
  };
}

class CurrentOrderData extends Model {
  late final int? orderId;
  late final String? status;
  late final DateTime? date;
  late final String? time;
  late final int? orderPrice;
  late final int? deliveryPrice;
  late final double? totalPrice;
  late final String? clientName;
  late final String? clientImage;
  late final String? phone;
  late final Address? address;
  late final String? location;
  List<Image>? images;
  late final String? payType;
  late final String? note;

  CurrentOrderData.fromJson([Map<String, dynamic>? json]) {
    orderId = intFromJson(json, "id");
    status = stringFromJson(json, "status");
    date = dateFromJson(json, "date");
    time = stringFromJson(json, "time");
    orderPrice = intFromJson(json, "order_price");
    deliveryPrice = intFromJson(json, "delivery_price");
    totalPrice = doubleFromJson(json, "total_price");
    clientName = stringFromJson(json, "client_name");
    clientImage = stringFromJson(json, "client_image");
    phone = stringFromJson(json, "phone");
    address = Address.fromJson(json?['address']);
    location = stringFromJson(json, "location");
    if (json?['images'] != null) {
      images = <Image>[];
      json?['images'].forEach((v) {
        images?.add(Image.fromJson(v));
      });
    }
    payType = stringFromJson(json, "pay_type");
    note = stringFromJson(json, "note");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": orderId,
    "status": status,
    "date": date?.toIso8601String(),
    "time": time,
    "order_price": orderPrice,
    "delivery_price": deliveryPrice,
    "total_price": totalPrice,
    "client_name": clientName,
    "client_image": clientImage,
    "phone": phone,
    "address": address?.toJson(),
    "location": location,
    "images": images?.map((v) => v.toJson()).toList(),
    "pay_type": payType,
    "note": note,
  };
}

class Address extends Model {
  late final int? addressId;
  late final String? type;
  late final double? lat;
  late final double? lng;
  late final String? location;
  late final String? description;
  late final int? userId;
  late final int? isDefault;
  late final String? phone;
  late final DateTime? createdAt;
  late final DateTime? updatedAt;

  Address.fromJson([Map<String, dynamic>? json]) {
    addressId = intFromJson(json, "id");
    type = stringFromJson(json, "type");
    lat = doubleFromJson(json, "lat");
    lng = doubleFromJson(json, "lng");
    location = stringFromJson(json, "location");
    description = stringFromJson(json, "description");
    userId = intFromJson(json, "user_id");
    isDefault = intFromJson(json, "is_default");
    phone = stringFromJson(json, "phone");
    createdAt = dateFromJson(json, "created_at");
    updatedAt = dateFromJson(json, "updated_at");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": addressId,
    "type": type,
    "lat": lat,
    "lng": lng,
    "location": location,
    "description": description,
    "user_id": userId,
    "is_default": isDefault,
    "phone": phone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Image extends Model {
  late final String? name;
  late final String? url;

  Image.fromJson([Map<String, dynamic>? json]) {
    name = stringFromJson(json, "name");
    url = stringFromJson(json, "url");
  }

  @override
  Map<String, dynamic> toJson() => {"name": name, "url": url};
}

class Links extends Model {
  late final String? first;
  late final String? last;
  late final dynamic prev;
  late final dynamic next;

  Links.fromJson([Map<String, dynamic>? json]) {
    first = stringFromJson(json, "first");
    last = stringFromJson(json, "last");
    prev = json?['prev'];
    next = json?['next'];
  }

  @override
  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta extends Model {
  late final int currentPage;
  late final int from;
  late final int lastPage;
  late final List<Link> links;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  Meta.fromJson([Map<String, dynamic>? json]) {
    currentPage = intFromJson(json, "current_page");
    from = intFromJson(json, "from");
    lastPage = intFromJson(json, "last_page");
    path = stringFromJson(json, "path");
    perPage = intFromJson(json, "per_page");
    to = intFromJson(json, "to");
    total = intFromJson(json, "total");
  }

  @override
  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links.map((v) => v.toJson()).toList(),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link extends Model {
  late final String url;
  late final String label;
  late final bool active;

  Link.fromJson([Map<String, dynamic>? json]) {
    url = stringFromJson(json, "url");
    label = stringFromJson(json, "label");
    active = boolFromJson(json, "active");
  }

  @override
  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}