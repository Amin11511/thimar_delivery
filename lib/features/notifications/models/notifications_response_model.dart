import '../../auth/login/models/base.dart';

class NotificationResponseModel extends Model {
  late final NotificationsData data;
  late final Links links;
  late  Meta meta;
  late final String status;
  late final String message;



  NotificationResponseModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    data = NotificationsData.fromJson(json?['data'] ?? {});
    links = Links.fromJson(json?['links'] ?? {});
    meta = Meta.fromJson(json?['meta'] ?? {});
    status = stringFromJson(json, "status");
    message = stringFromJson(json, "message");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "data": data.toJson(),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "status": status,
    "message": message,
  };
}

class NotificationsData extends Model {
  late final int unreadNotificationsCount;
  List<AppNotification> notifications=[];

  NotificationsData.fromJson([Map<String, dynamic>? json]) {
    unreadNotificationsCount = intFromJson(json, "unreadnotifications_count");
    notifications = listFromJson(
      json,
      "notifications",
      callback: (v) => AppNotification.fromJson(v),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "unreadnotifications_count": unreadNotificationsCount,
    "notifications": notifications.map((e) => e.toJson()).toList(),
  };
}

class AppNotification extends Model {
  late final String title;
  late final String image;
  late final String createdAt;
  late final String notifyType;
  late final Order order;

  AppNotification.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    title = stringFromJson(json, "title");
    image = stringFromJson(json, "image");
    createdAt = stringFromJson(json, "created_at");
    notifyType = stringFromJson(json, "notify_type");
    order = Order.fromJson(json?['order'] ?? {});
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "created_at": createdAt,
    "notify_type": notifyType,
    "order": order.toJson(),
  };
}

class Order extends Model {
  late final int orderId;
  late final int clientId;
  late final int driverId;
  late final String orderType;
  late final String orderStatus;

  Order.fromJson([Map<String, dynamic>? json]) {
    orderId = intFromJson(json, "order_id");
    clientId = intFromJson(json, "client_id");
    driverId = intFromJson(json, "driver_id");
    orderType = stringFromJson(json, "order_type");
    orderStatus = stringFromJson(json, "order_status");
  }

  @override
  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "client_id": clientId,
    "driver_id": driverId,
    "order_type": orderType,
    "order_status": orderStatus,
  };
}

class Links extends Model {
  late final String first;
  late final String last;
  late final String prev;
  late final String next;

  Links.fromJson([Map<String, dynamic>? json]) {
    first = stringFromJson(json, "first");
    last = stringFromJson(json, "last");
    prev = stringFromJson(json, "prev");
    next = stringFromJson(json, "next");
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
  List<Link> links=[];
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
    links = listFromJson(json, "links", callback: (v) => Link.fromJson(v));
  }

  @override
  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links.map((e) => e.toJson()).toList(),
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