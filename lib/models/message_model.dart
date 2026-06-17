class Message {
  final int id;
  final String senderName;
  final String text;
  final String time;
  final int unreadCount;
  final String avatar;
  final bool isOnline;

  Message({
    required this.id,
    required this.senderName,
    required this.text,
    required this.time,
    required this.unreadCount,
    this.avatar = '',
    this.isOnline = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: (json['id'] as num).toInt(),
      senderName: json['sender_name'] as String,
      text: json['text'] as String,
      time: json['time'] as String,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      avatar: json['avatar'] as String? ?? '',
      isOnline: json['is_online'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_name': senderName,
      'text': text,
      'time': time,
      'unread_count': unreadCount,
      'avatar': avatar,
      'is_online': isOnline,
    };
  }
}

class ChatDetail {
  final int id;
  final String text;
  final String time;
  final bool isMe;

  ChatDetail({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });

  factory ChatDetail.fromJson(Map<String, dynamic> json) {
    return ChatDetail(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      time: json['time'] as String,
      isMe: json['is_me'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'time': time,
      'is_me': isMe,
    };
  }
}
