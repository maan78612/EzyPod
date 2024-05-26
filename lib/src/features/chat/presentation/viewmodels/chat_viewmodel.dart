import 'package:ezy_pod/src/core/commons/custom_text_controller.dart';
import 'package:ezy_pod/src/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_message.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_room.dart';
import 'package:ezy_pod/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatViewModel with ChangeNotifier {
  final Ref _ref;
  final ChatRepository _charRepository = ChatRepositoryImpl();
  List<ChatRoom> charRoomList = [];

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
    charRoomList = _charRepository.fetchChatRoom();
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

}
