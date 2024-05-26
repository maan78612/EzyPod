import 'package:ezy_pod/src/features/chat/domain/models/chat_message.dart';

class ChatRoom {
  String? id;
  List<ChatUser> chatUsers;
  DateTime? createAt;
  List<ChatMessage> messages;

  ChatRoom({
    this.id,
    required this.chatUsers,
    this.createAt,
    this.messages = const [],
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'],
      chatUsers: (json['users'] as List)
          .map((user) => ChatUser.fromJson(user))
          .toList(),
      createAt: json['create_at'],
      messages: (json['messages'] as List)
          .map((message) => ChatMessage.fromJson(message))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users': chatUsers.map((user) => user.toJson()).toList(),
      'create_at': createAt,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

class ChatUser {
  String? id;
  String? name;
  String? image;

  ChatUser({
    this.id,
    this.name,
    this.image,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
