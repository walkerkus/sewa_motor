class Message {
  final String id;
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
    this.isOnline = true,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      senderName: json['senderName'] as String,
      text: json['text'] as String,
      time: json['time'] as String,
      unreadCount: json['unreadCount'] as int,
      avatar: json['avatar'] as String? ?? '',
      isOnline: json['isOnline'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'text': text,
      'time': time,
      'unreadCount': unreadCount,
      'avatar': avatar,
      'isOnline': isOnline,
    };
  }
}

class ChatDetail {
  final String id;
  final String text;
  final String time;
  final bool isMe;

  ChatDetail({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });
}
