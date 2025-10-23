import '../../auth/login/models/base.dart';

class FqsModel extends Model {
  final String? status;
  final String? message;
  final List<FqsData>? data;

  FqsModel({this.status, this.message, this.data});

  factory FqsModel.fromJson(Map<String, dynamic> json) {
    return FqsModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? List<FqsData>.from(
          (json['data'] as List).map((x) => FqsData.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class FqsData {
  final int? id;
  final String? question;
  final String? answer;

  FqsData({this.id, this.question, this.answer});

  factory FqsData.fromJson(Map<String, dynamic> json) {
    return FqsData(
      id: json['id'] as int?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}