import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_message.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_room.dart';
import 'package:ezy_pod/src/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  List<ChatRoom> fetchChatRoom() {
    List<ChatRoom> chatRoomList = [];

    chatRoomList.add(ChatRoom(
      id: "1",
      chatUsers: [
        ChatUser(id: '1', name: 'John', image: AppImages.user1),
        ChatUser(id: '2', name: 'Jane', image: AppImages.user2)
      ],
      createAt: DateTime.now(),
      messages: [
        ChatMessage(
          id: "1",
          text: "Hello!",
          senderId: "1",
          senderName: "John",
          timestamp: DateTime.now(),
          read: false,
        ),
        ChatMessage(
          id: "2",
          text: "Hi!",
          senderId: "2",
          senderName: "Jane",
          timestamp: DateTime.now().add(const Duration(minutes: 1)),
          read: true,
        ),
        ChatMessage(
          id: "3",
          text: "How are you?",
          senderId: "1",
          senderName: "John",
          timestamp: DateTime.now().add(const Duration(minutes: 2)),
          read: false,
        ),
        ChatMessage(
          id: "4",
          text: "I'm good, thanks!",
          senderId: "2",
          senderName: "Jane",
          timestamp: DateTime.now().add(const Duration(minutes: 3)),
          read: true,
        ),
      ],
    ));
    chatRoomList.add(ChatRoom(
      id: "2",
      chatUsers: [
        ChatUser(id: '3', name: 'Lavern', image: AppImages.user2),
        ChatUser(id: '4', name: 'Laboy', image: AppImages.user1)
      ],
      createAt: DateTime.now(),
      messages: [
        ChatMessage(
          id: "1",
          text: "How are you!",
          senderId: "3",
          senderName: "Lavern",
          timestamp: DateTime.now(),
          read: false,
        ),
        ChatMessage(
          id: "2",
          text: "I am fine!",
          senderId: "4",
          senderName: "Laboy",
          timestamp: DateTime.now().add(const Duration(minutes: 1)),
          read: true,
        ),
        ChatMessage(
          id: "3",
          text: "That's great",
          senderId: "3",
          senderName: "Lavern",
          timestamp: DateTime.now().add(const Duration(minutes: 2)),
          read: false,
        ),
        ChatMessage(
          id: "4",
          text: "Did you have today's assignment questions?",
          senderId: "4",
          senderName: "Laboy",
          timestamp: DateTime.now().add(const Duration(minutes: 3)),
          read: true,
        ),
        ChatMessage(
          id: "5",
          text: "Math's assignment*",
          senderId: "4",
          senderName: "Laboy",
          timestamp: DateTime.now().add(const Duration(minutes: 3)),
          read: true,
        ),
      ],
    ));
    return chatRoomList;
  }

  @override
  void sendMessage(ChatMessage message, ChatRoom chatRoom) {
    chatRoom.messages.add(message);

    print(chatRoom.toJson());
  }
}
