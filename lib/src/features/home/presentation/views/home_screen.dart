import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/core/enums/delivery_status.dart';
import 'package:ezy_pod/src/features/chat/presentation/views/chat_room_screen.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/deliveries_screen.dart';
import 'package:ezy_pod/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:ezy_pod/src/features/notifications/presentation/views/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends ConsumerWidget {
  final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
    return HomeViewModel(ref);
  });

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              30.verticalSpace,
              Text("Welcome Ibrahim!",
                  style: InterStyles.semiBold
                      .copyWith(color: AppColors.blackColor, fontSize: 30.sp)),
              16.verticalSpace,
              Text("BDRR RZV",
                  style: InterStyles.medium
                      .copyWith(color: AppColors.blackColor, fontSize: 24.sp)),
              16.verticalSpace,
              Expanded(
                child: ListView(
                  children: [
                    homeCards(
                        img: AppImages.pendingDelivery,
                        title: "Pending Deliveries",
                        count: "25",
                        onTap: () {
                          CustomNavigation().push(DeliveryScreen(
                            listLength: 25,
                            deliveryStatus: DeliveryStatus.pendingDeliveries,
                          ));
                        }),
                    homeCards(
                        img: AppImages.todayDelivery,
                        title: "Delivered Today",
                        count: "5",
                        onTap: () {
                          CustomNavigation().push(DeliveryScreen(
                            listLength: 5,
                            deliveryStatus: DeliveryStatus.deliveredToday,
                          ));
                        }),
                    homeCards(
                        img: AppImages.undelivered,
                        title: "Undelivered Today",
                        count: "1",
                        onTap: () {
                          CustomNavigation().push(DeliveryScreen(
                            listLength: 1,
                            deliveryStatus: DeliveryStatus.undeliveredToday,
                          ));
                        }),
                    homeCards(
                        img: AppImages.notifications,
                        title: "Notifications",
                        count: "2",
                        onTap: () {
                          CustomNavigation().push(NotificationScreen());
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget homeCards(
      {required String img,
      required String title,
      required String count,
      required Function() onTap}) {
    return CommonInkWell(
      onTap: onTap,
      child: Container(
        height: 110.h,
        padding: EdgeInsets.all(16.sp),
        margin: EdgeInsets.only(bottom: 12.sp),
        width: ScreenUtil().screenWidth,
        // Set your desired width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          // Add rounded corners
          border: Border.all(color: AppColors.lightGreyColor),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF5F0DD),
              Color(0xFFF5F5F5),
              Color(0xFFF5F5F5),
              Color(0xFFE6E9F4), // End color
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              img,
              width: 40.sp,
            ),
            16.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: InterStyles.medium),
                12.verticalSpace,
                Text(count,
                    style: InterStyles.bold
                        .copyWith(fontSize: 30.sp, color: AppColors.blackColor))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Row(children: [
        SvgPicture.asset(AppImages.appIcon, width: 40.sp),
        const Spacer(),
        Image.asset(AppImages.car, width: 70.sp),
        const Spacer(),
        CommonInkWell(
            onTap: () => CustomNavigation().push(ChatRoomScreen()),
            child: SvgPicture.asset(AppImages.chat, width: 18.sp)),
        16.horizontalSpace,
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(200.r)),
            child: Image.asset(AppImages.profile, width: 25.sp)),
      ]),
    );
  }
}
