class PointHistoryModel {
  final int id;
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
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      points: (json['points'] as num).toInt(),
      date: json['date'] as String,
      isEarned: json['is_earned'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'points': points,
      'date': date,
      'is_earned': isEarned,
    };
  }
}
