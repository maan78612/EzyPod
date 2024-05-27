import 'package:another_flushbar/flushbar.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/enums/snackbar_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Utils {
  static customSnackBar(String msg, SnackBarType type, BuildContext context) {
    Flushbar(
      title: type.name.toUpperCase(),
      titleColor: Colors.white,
      message: msg,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: type == SnackBarType.error
          ? AppColors.redColor
          : type == SnackBarType.success
              ? AppColors.greenColor
              : type == SnackBarType.info
                  ? AppColors.primaryColor
                  : Colors.yellowAccent,
      isDismissible: false,
      duration: const Duration(seconds: 2),
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(100.0.r),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(4.sp),
          child: Icon(
            size: 12.sp,
            type == SnackBarType.error
                ? Icons.error
                : type == SnackBarType.success
                    ? Icons.done
                    : type == SnackBarType.info
                        ? Icons.info
                        : Icons.warning,
            color: type == SnackBarType.error
                ? AppColors.redColor
                : type == SnackBarType.success
                    ? AppColors.greenColor
                    : type == SnackBarType.info
                        ? AppColors.primaryColor
                        : Colors.yellowAccent,
          ),
        ),
      ),
    ).show(context);
  }
}
