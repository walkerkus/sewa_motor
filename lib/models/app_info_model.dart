class AppInfoModel {
  final String id;
  final String title;
  final String content;

  AppInfoModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    return AppInfoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
