import '../../auth/login/models/base.dart';

class AboutAppModel extends Model {
  final String? about;

  AboutAppModel({this.about});

  factory AboutAppModel.fromJson(Map<String, dynamic> json) {
    return AboutAppModel(about: json['data']?['about'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {'about': about},
    };
  }
}