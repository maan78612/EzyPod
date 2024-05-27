import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/features/notifications/presentation/viewmodels/notifications_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends ConsumerWidget {
  final notificationsViewModelProvider =
      ChangeNotifierProvider<NotificationsViewModel>((ref) {
    return NotificationsViewModel(ref);
  });

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationViewModel = ref.watch(notificationsViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        bottom:  PreferredSize(
            preferredSize: Size.fromHeight(10.sp),
            child: const Divider(color: AppColors.borderColor)),
        title: Text(
          'Notifications',
          style: InterStyles.semiBold
              .copyWith(fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: List.generate(4, (index) => notificationTile()),
      )),
    );
  }

  Widget notificationTile() {
    return Container(
      color: const Color(0xffFCFCFD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                Container(
                  width: 40.sp,
                  height: 40.sp,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff2C833B)),
                  child: Text(
                    "AR",
                    style: InterStyles.medium
                        .copyWith(fontSize: 16.sp, color: AppColors.whiteColor),
                  ),
                ),
                18.horizontalSpace,
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Abdul Rahim",
                        style: InterStyles.semiBold.copyWith(fontSize: 14.sp),
                      ),
                      TextSpan(
                        text: " has add you",
                        style: InterStyles.regular.copyWith(fontSize: 12.sp),
                      ),
                      TextSpan(
                        text: "\non 3rd, Aug 2023)",
                        style: InterStyles.regular
                            .copyWith(fontSize: 12.sp, height: 1.5),
                      ),
                      TextSpan(
                        text: "\n1 hour ago)",
                        style: InterStyles.regular
                            .copyWith(fontSize: 12.sp, height: 1.5),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(color: AppColors.borderColor,height: 1,),
        ],
      ),
    );
  }
}
