class ChatMessage {
  String? id;
  String? text;
  String? senderId;
  String? senderName;
  DateTime? timestamp;
  bool? read;

  ChatMessage({
    this.id,
    this.text,
    this.senderId,
    this.senderName,
    this.timestamp,
    this.read,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      text: json['text'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      timestamp: DateTime.parse(json['timestamp']),
      read: json['read'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': timestamp!.toIso8601String(),
      'read': read,
    };
  }
}
