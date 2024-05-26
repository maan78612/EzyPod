import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_input_field.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_message.dart';
import 'package:ezy_pod/src/features/chat/domain/models/chat_room.dart';
import 'package:ezy_pod/src/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends ConsumerWidget {
  final ChangeNotifierProvider<ChatViewModel> chatViewModelProvider;
  final ChatRoom chatRoom;
  final ChatUser otherUser;
  final ChatUser myUser;

  const ChatScreen(
      {super.key,
      required this.chatViewModelProvider,
      required this.chatRoom,
      required this.otherUser,
      required this.myUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatViewModel = ref.watch(chatViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(16.sp),
            child: const Divider(color: AppColors.borderColor)),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: Image.asset(otherUser.image!, width: 40.w),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${otherUser.name}',
                    style: InterStyles.semiBold
                        .copyWith(fontSize: 20.sp, color: AppColors.blackColor),
                  ),
                  2.verticalSpace,
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.greenAccent),
                        child: SizedBox(height: 10.sp, width: 10.sp),
                      ),
                      5.horizontalSpace,
                      Text(
                        "online",
                        style: InterStyles.medium.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.blackColor.withOpacity(0.4)),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Display the picture if the message has one
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            16.verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: chatRoom.messages.length,
                itemBuilder: (context, index) {
                  ChatMessage message = chatRoom.messages[index];
                  final isOtherUserMessage = message.senderId == otherUser.id;
                  String? imageUrl;
                  if (isOtherUserMessage) {
                    imageUrl = otherUser.image;
                  } else {
                    imageUrl = myUser.image;
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: isOtherUserMessage
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isOtherUserMessage) ...[
                              imageAvatar(imageUrl: imageUrl!),
                              16.horizontalSpace,
                            ],
                            Flexible(
                              child: messageBubble(
                                isOtherUserMessage: isOtherUserMessage,
                                message: message.text!,
                              ),
                            ),
                            if (!isOtherUserMessage) ...[
                              16.horizontalSpace,
                              imageAvatar(imageUrl: imageUrl!),
                            ],
                          ],
                        ),
                        6.verticalSpace,
                      ],
                    ),
                  );
                },
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(color: AppColors.borderColor),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomInputField(
                          controller: chatViewModel.typeMsg,
                          hint: "Message",
                        ),
                      ),
                      CommonInkWell(
                        onTap: () {
                          chatViewModel.sendMessage(
                              message: ChatMessage(
                                id: DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString(),
                                text: chatViewModel.typeMsg.controller.text,
                                senderId: myUser.id,
                                senderName: myUser.name,
                                timestamp: DateTime.now(),
                                read: false,
                              ),
                              chatRoom: chatRoom);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.sp),
                          margin: EdgeInsets.only(left: 12.sp),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r))),
                          child: SvgPicture.asset(AppImages.sendMessage),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageAvatar({required String imageUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      child: Image.asset(imageUrl, width: 48.w),
    );
  }

  Widget messageBubble(
      {required bool isOtherUserMessage, required String message}) {
    return Column(
      crossAxisAlignment: isOtherUserMessage
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(8.sp),
          margin: EdgeInsets.only(
            right: isOtherUserMessage ? 50.sp : 0,
            left: isOtherUserMessage ? 0 : 50.sp,
          ),
          decoration: BoxDecoration(
            color: isOtherUserMessage
                ? const Color(0xffF3F3F3)
                : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Text(
            message,
            style: InterStyles.regular.copyWith(
              fontSize: 14.sp,
              color: isOtherUserMessage
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.sp),
          child: Text(
            "11:50am",
            style: InterStyles.regular.copyWith(fontSize: 12.sp),
          ),
        )
      ],
    );
  }
}
