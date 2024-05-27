import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_input_field.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_room.dart';
import 'package:ezy_pod/src/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:ezy_pod/src/features/chat/presentation/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final chatViewModelProvider = ChangeNotifierProvider<ChatViewModel>((ref) {
    return ChatViewModel(ref);
  });

  @override
  void initState() {
    ref.read(chatViewModelProvider).fetchChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = ref.watch(chatViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2),
            child: Divider(color: AppColors.borderColor)),
        title: Text(
          'Chat',
          style: InterStyles.semiBold
              .copyWith(fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          children: [
            CustomInputField(
              controller: chatViewModel.searchCon,
              hint: "Search",
              onChange: (value) {
                chatViewModel.searchChatRooms(value);
              },
              prefixWidget: Icon(
                Icons.search,
                color: const Color(0xff9CA3AF),
                size: 20.sp,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatViewModel.filteredChatRoomList.length,
                itemBuilder: (context, index) {
                  final chatRoomData =
                      chatViewModel.filteredChatRoomList[index];
                  return MessageTile(
                    chatRoomData: chatRoomData,
                    chatViewModelProvider: chatViewModelProvider,

                    /// TODO: change this we do back-end
                    otherUser: chatRoomData.chatUsers
                        .firstWhere((user) => (user.id != '1')),
                    myUser: chatRoomData.chatUsers
                        .firstWhere((user) => (user.id == '1')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CommonInkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(8.sp),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: Icon(Icons.add, color: AppColors.whiteColor, size: 33.sp),
        ),
      ),
    );
  }
}

// Message tile widget
class MessageTile extends ConsumerWidget {
  final ChatRoom chatRoomData;
  final ChatUser otherUser;
  final ChatUser myUser;

  final ChangeNotifierProvider<ChatViewModel> chatViewModelProvider;

  const MessageTile(
      {super.key,
      required this.chatRoomData,
      required this.otherUser,
      required this.myUser,
      required this.chatViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatViewModel = ref.watch(chatViewModelProvider);
    return CommonInkWell(
      onTap: () {
        CustomNavigation().push(ChatScreen(
          chatViewModelProvider: chatViewModelProvider,
          chatRoom: chatRoomData,
          otherUser: otherUser,
          myUser: myUser,
        ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: Image.asset(otherUser.image!, width: 48.w),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${otherUser.name}',
                          style: InterStyles.semiBold.copyWith(
                              fontSize: 14.sp, color: AppColors.blackColor),
                        ),
                      ),
                      Text(
                        chatViewModel.showDataTimeAgoString(chatRoomData.messages.last.timestamp),
                        style: InterStyles.medium.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.blackColor.withOpacity(0.4)),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Text(
                    "${chatRoomData.messages.last.text}",
                    style: InterStyles.medium.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.blackColor.withOpacity(0.4)),
                  )
                ],
              ),
            ),

            // Display the picture if the message has one
          ],
        ),
      ),
    );
  }
}
