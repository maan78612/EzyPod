import 'dart:io';

import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageCard extends ConsumerWidget {
  final ChangeNotifierProvider<DeliveryFormViewModel>
      deliveryFormViewModelProvider;

  const UploadImageCard(
      {super.key, required this.deliveryFormViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryViewModel = ref.watch(deliveryFormViewModelProvider);
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(vertical: 16.sp),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      alignment: Alignment.center,
      child: deliveryViewModel.uploadedImage == null
          ? Column(
              children: [
                SvgPicture.asset(AppImages.upload),
                12.verticalSpace,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () async {
                            _showImageOptions(context, deliveryViewModel);
                          },
                          child: Text(
                            "Click to upload",
                            style: InterStyles.semiBold.copyWith(
                                fontSize: 14.sp, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " a image",
                        style: InterStyles.regular.copyWith(fontSize: 14.sp),
                      ),
                      TextSpan(
                        text: "\nSVG, PNG, JPG or GIF (max. 800x400px)",
                        style: InterStyles.regular
                            .copyWith(fontSize: 12.sp, height: 1.5),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0.r),
                      child: Image.file(
                        deliveryViewModel.uploadedImage!,
                        fit: BoxFit.fitWidth,
                        height: 85.h,
                      ),
                    ),
                  ),
                ),
                CommonInkWell(
                  onTap: (){
                    deliveryViewModel.removeUploadedImg();
                  },
                    child: const Icon(
                  Icons.delete_forever,
                  color: AppColors.redColor,
                )),
                20.horizontalSpace,
              ],
            ),
    );
  }

  void _showImageOptions(
      BuildContext context, DeliveryFormViewModel deliverFormViewModel) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: Text('Camera', style: InterStyles.regular),
                onTap: () async {
                  await deliverFormViewModel
                      .imageOptionClick(ImageSource.camera);
                  CustomNavigation().pop();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.image,
                ),
                title: Text('Gallery', style: InterStyles.regular),
                onTap: () async {
                  await deliverFormViewModel
                      .imageOptionClick(ImageSource.gallery);
                  CustomNavigation().pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
