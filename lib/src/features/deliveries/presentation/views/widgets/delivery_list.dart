import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/enums/delivery_status.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_viewmodel.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/pending_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryList extends ConsumerWidget {
  final DeliveryStatus deliveryStatus;
  final ChangeNotifierProvider<DeliveryViewModel> deliveryViewModelProvider;
  final int listLength;

  const DeliveryList({
    super.key,
    required this.deliveryViewModelProvider,
    required this.deliveryStatus,
    required this.listLength,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryViewModel = ref.watch(deliveryViewModelProvider);
    return Column(
      children: [
        30.verticalSpace,
        listTitleWidget(),
        listWidget(deliveryViewModel),
      ],
    );
  }

  Widget listWidget(DeliveryViewModel deliveryViewModel) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
          deliveryViewModel.nextDataListLength(listLength),
          (index) => CommonInkWell(
                onTap: () {
                  if (deliveryStatus == DeliveryStatus.pendingDeliveries) {
                    CustomNavigation().push(PendingDetailScreen(
                      deliveryViewModelProvider: deliveryViewModelProvider,
                    ));
                  }
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.sp, vertical: 22.sp),
                      child: Row(
                        children: [
                          customTextWidget(
                              "${deliveryViewModel.currentIndex + index + 1}",
                              1),
                          customTextWidget("ABC Limited", 3),
                          customTextWidget("BB5 5BY", 3,
                              textAlignment: TextAlign.center),
                        ],
                      ),
                    ),
                    const Divider(color: AppColors.borderColor, height: 1),
                  ],
                ),
              )),
    );
  }

  Widget customTextWidget(String title, int flexVal,
      {TextAlign? textAlignment, double? font}) {
    return Expanded(
      flex: flexVal,
      child: Text(
        title,
        textAlign: textAlignment ?? TextAlign.start,
        style: InterStyles.medium
            .copyWith(fontSize: font ?? 14.sp, color: AppColors.lightTextColor),
      ),
    );
  }

  Widget listTitleWidget() {
    return Container(
      color: const Color(0xffF9FAFB),
      child: Column(
        children: [
          const Divider(color: AppColors.borderColor, height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 16.sp),
            child: Row(
              children: [
                customTextWidget("#", 1, font: 12.sp),
                customTextWidget("Customer", 3, font: 12.sp),
                customTextWidget("Post Code", 3,
                    font: 12.sp, textAlignment: TextAlign.center),
              ],
            ),
          ),
          const Divider(color: AppColors.borderColor, height: 1),
        ],
      ),
    );
  }
}
