class FinishedOrdersModel {
  final List<dynamic> data;
  final Links links;
  final Meta meta;
  final String status;
  final String message;

  FinishedOrdersModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  factory FinishedOrdersModel.fromJson(Map<String, dynamic> json) {
    return FinishedOrdersModel(
      data: json['data'] ?? [],
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }
}

class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}

class Meta {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<PageLink> links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    required this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      links: (json['links'] as List)
          .map((e) => PageLink.fromJson(e))
          .toList(),
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class PageLink {
  final String? url;
  final String? label;
  final bool active;

  PageLink({
    this.url,
    this.label,
    required this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'],
      label: json['label'],
      active: json['active'] ?? false,
    );
  }
}
