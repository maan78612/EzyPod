import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/core/enums/delivery_status.dart';
import 'package:ezy_pod/src/features/chat/presentation/views/chat_room_screen.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/deliveries_screen.dart';
import 'package:ezy_pod/src/features/home/domain/models/deliveries.dart';
import 'package:ezy_pod/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:ezy_pod/src/features/notifications/presentation/views/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
    return HomeViewModel();
  });

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => ref.read(homeViewModelProvider).onInit());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ModalProgressHUD(
        inAsyncCall: homeViewModel.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                30.verticalSpace,
                Text("Welcome Ibrahim!",
                    style: InterStyles.semiBold.copyWith(
                        color: AppColors.blackColor, fontSize: 30.sp)),
                16.verticalSpace,
                Text("BDRR RZV",
                    style: InterStyles.medium.copyWith(
                        color: AppColors.blackColor, fontSize: 24.sp)),
                16.verticalSpace,
                Expanded(
                  child: ListView(children: [
                    homeCards(
                        img: AppImages.pendingDelivery,
                        title: "Pending Deliveries",
                        deliveriesList:
                            (homeViewModel.deliveryData?.results ?? [])
                                .where((delivery) =>
                                    delivery.status == DeliveryStatus.pending)
                                .toList(),
                        homeViewModel: homeViewModel),
                    homeCards(
                        img: AppImages.todayDelivery,
                        title: "Delivered Today",
                        homeViewModel: homeViewModel,
                        deliveriesList:
                            (homeViewModel.deliveryData?.results ?? [])
                                .where((delivery) =>
                                    delivery.status == DeliveryStatus.delivered)
                                .toList()),
                    homeCards(
                        img: AppImages.undelivered,
                        title: "Undelivered Today",
                        homeViewModel: homeViewModel,
                        deliveriesList: (homeViewModel.deliveryData?.results ??
                                [])
                            .where((delivery) =>
                                delivery.status == DeliveryStatus.undelivered)
                            .toList()),
                    notificationCard(
                        img: AppImages.notifications,
                        title: "Notifications",
                        count: "2"),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget homeCards({
    required String img,
    required String title,
    required HomeViewModel homeViewModel,
    required List<DeliveriesResult> deliveriesList,
  }) {
    return CommonInkWell(
      onTap: () => CustomNavigation().push(DeliveryScreen(
        deliveriesList: deliveriesList,
        addresses: homeViewModel.addressList,
        appTitle: title,
      )),
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
                Text(deliveriesList.length.toString(),
                    style: InterStyles.bold
                        .copyWith(fontSize: 30.sp, color: AppColors.blackColor))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget notificationCard(
      {required String img, required String title, required String count}) {
    return CommonInkWell(
      onTap: () => CustomNavigation().push(NotificationScreen()),
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
