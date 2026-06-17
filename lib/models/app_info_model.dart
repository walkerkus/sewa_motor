class AppInfoModel {
  final int id;
  final String title;
  final String content;
  final String type; // 'terms' atau 'privacy'

  AppInfoModel({
    required this.id,
    required this.title,
    required this.content,
    this.type = '',
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    return AppInfoModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      type: json['type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type,
    };
  }
}
