import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryListButton extends StatelessWidget {
  final DeliveryViewModel deliveryViewModel;
  final int listLength;

  const DeliveryListButton(
      {super.key, required this.deliveryViewModel, required this.listLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 24.sp, right: 24.sp, top: 12.sp, bottom: 16.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonWidget(
                  title: "Previous",
                  icon: AppImages.leftArrow,
                  onTap: () {
                    deliveryViewModel.onPreviousClicked();
                  }),
              buttonWidget(
                  title: "Next",
                  icon: AppImages.rightArrow,
                  onTap: () {
                     deliveryViewModel.onNextClicked(listLength);
                  }),
            ],
          ),
        ),
        const Divider(color: AppColors.borderColor, height: 1),
      ],
    );
  }

  Widget buttonWidget(
      {required String title,
      required String icon,
      required Function() onTap}) {
    return CommonInkWell(
      onTap: onTap,
      child: Container(
        width: 114.w,
        height: 36.h,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 11.sp,
              colorFilter: const ColorFilter.mode(
                  AppColors.lightTextColor, BlendMode.srcIn),
            ),
            13.horizontalSpace,
            Text(
              title,
              style: InterStyles.medium
                  .copyWith(fontSize: 14.sp, color: AppColors.lightTextColor),
            )
          ],
        ),
      ),
    );
  }
}
