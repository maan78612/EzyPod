import 'package:ezy_pod/src/features/chat/domain/models/chat_message.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_room.dart';

abstract class ChatRepository {
  List<ChatRoom> fetchChatRoom();

  void sendMessage(ChatMessage message, ChatRoom chatRoom);
}
