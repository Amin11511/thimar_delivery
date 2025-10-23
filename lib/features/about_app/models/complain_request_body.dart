class ComplainRequestBody {
  final String name;
  final String phone;
  final String title;
  final String content;

  ComplainRequestBody({
    required this.name,
    required this.phone,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    "fullname": name,
    "phone": phone,
    "title": title,
    "content": content,
  };
}