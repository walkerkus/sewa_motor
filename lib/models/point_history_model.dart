class PointHistoryModel {
  final String id;
  final String title;
  final int points;
  final String date;
  final bool isEarned;

  PointHistoryModel({
    required this.id,
    required this.title,
    required this.points,
    required this.date,
    required this.isEarned,
  });

  factory PointHistoryModel.fromJson(Map<String, dynamic> json) {
    return PointHistoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      points: json['points'] as int,
      date: json['date'] as String,
      isEarned: json['isEarned'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'points': points,
      'date': date,
      'isEarned': isEarned,
    };
  }
}
