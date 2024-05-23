import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/features/home/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar {
  static PreferredSize deliveryAppBar({required String title}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
          backgroundColor: AppColors.whiteColor,
          surfaceTintColor: Colors.transparent,
          leading: CommonInkWell(
            onTap: () {
              CustomNavigation()
                  .pushAndRemoveUntil(HomeScreen(), animate: false);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: SvgPicture.asset(AppImages.home),
            ),
          ),
          leadingWidth: 30.sp,
          title: Text(
            title,
            style: InterStyles.semiBold
                .copyWith(fontSize: 14.sp, color: AppColors.blackColor),
          ),
          actions: [
            CommonInkWell(
              onTap: () {
                CustomNavigation().pop();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 12.sp),
                child: SvgPicture.asset(AppImages.back, width: 18.sp),
              ),
            ),
          ]),
    );
  }
}
