import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isEnable;
  final Function() onPressed;
  final Color bgColor;
  final Color textColor;
  final Color loadingColor;
  final bool isLoading;
  final double loadingSize;

  const CustomButton(
      {super.key,
      required this.title,
      required this.bgColor,
      this.isEnable = true,
      this.loadingColor = AppColors.whiteColor,
      this.isLoading = false,
      this.loadingSize = 25.0,
      this.textColor = AppColors.whiteColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CommonInkWell(
      onTap: isEnable ? onPressed : null,
      child: Container(
        width: ScreenUtil().screenWidth,
        height: inputFieldHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: bgColor.withOpacity(isEnable ? 1 : 0.5)),
        child: isLoading
            ? Container(
                height: loadingSize,
                width: loadingSize,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
                ),
              )
            : Text(title,
                textAlign: TextAlign.center,
                style: InterStyles.semiBold.copyWith(color: textColor)),
      ),
    );
  }
}
