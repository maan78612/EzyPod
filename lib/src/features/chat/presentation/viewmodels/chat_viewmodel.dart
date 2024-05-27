import 'package:ezy_pod/src/core/commons/custom_text_controller.dart';
import 'package:ezy_pod/src/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_message.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_room.dart';
import 'package:ezy_pod/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatViewModel with ChangeNotifier {
  final Ref _ref;
  final ChatRepository _charRepository = ChatRepositoryImpl();
  List<ChatRoom> _charRoomList = [];
  List<ChatRoom> _filteredChatRoomList = [];

  List<ChatRoom> get filteredChatRoomList => _filteredChatRoomList;

  ChatViewModel(this._ref);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /*==================== Chat Room ===============================*/
  CustomTextController searchCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  void fetchChatRooms() {
    _charRoomList = _charRepository.fetchChatRoom();
    filteredChatRoomList.addAll(_charRoomList);
  }

  String showDataTimeAgoString(DateTime? date) {
    if (date != null) {
      DateTime currentDateTime = DateTime.now();
      Duration difference = currentDateTime.difference(date);
      String formattedTime;

      if (difference.inHours > 0) {
        formattedTime = '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        formattedTime = '${difference.inMinutes} minutes ago';
      } else {
        formattedTime = 'Just now';
      }

      return formattedTime;
    }

    return "";
  }

/*==================== Chat Screen ===============================*/

  CustomTextController typeMsg = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  void sendMessage({required ChatMessage message, ChatRoom? chatRoom}) {
    if (chatRoom != null) {
      _charRepository.sendMessage(message, chatRoom);
      typeMsg.controller.clear();
    } else {
      // Create chat room then add message
    }
    notifyListeners();
  }

  void searchChatRooms(String query) {
    final filteredList = _charRoomList.where((chatRoom) {
      return chatRoom.chatUsers.any((user) =>
          user.id != "1" &&
          (user.name ?? "").toLowerCase().contains(query.toLowerCase()));
    }).toList();

    _filteredChatRoomList = filteredList;
    notifyListeners();
  }

  String formattedMsgDate(DateTime? date) {
    if (date != null) {
      String formattedTime = DateFormat('HH:mm').format(date);
      return formattedTime;
    }

    return "";
  }
}
