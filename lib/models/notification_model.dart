class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String time;
  final String type; // 'Promo', 'Booking', 'Pembayaran', 'Sistem'
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'type': type,
      'is_read': isRead,
    };
  }
}
