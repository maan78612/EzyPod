import 'package:ezy_pod/src/core/commons/custom_button.dart';
import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

class SignaturePad extends ConsumerWidget {
  final ChangeNotifierProvider<DeliveryFormViewModel>
      deliveryFormViewModelProvider;

  const SignaturePad({super.key, required this.deliveryFormViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryViewModel = ref.watch(deliveryFormViewModelProvider);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: ScreenUtil().screenWidth,
          height: 120.h,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          alignment: Alignment.center,
          child: deliveryViewModel.signatureBytes != null
              ? Image.memory(
                  deliveryViewModel.signatureBytes!,
                  fit: BoxFit
                      .contain, // Adjust the fit property as per your requirement
                )
              : Text("Please upload your Signature",
                  style: InterStyles.regular.copyWith(fontSize: 12.sp)),
        ),
        CommonInkWell(
          onTap: () async {
            onUploadClick(deliveryViewModel, context);
          },
          child: Container(
            padding: EdgeInsets.all(8.0.sp),
            margin: EdgeInsets.all(8.0.sp),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
            child: Text(
              "Upload",
              style: InterStyles.semiBold
                  .copyWith(fontSize: 12.sp, color: AppColors.blackColor),
            ),
          ),
        )
      ],
    );
  }

  void onUploadClick(
    DeliveryFormViewModel deliveryViewModel,
    BuildContext context,
  ) async {
    deliveryViewModel.clearSignaturePad();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(24.sp),
          backgroundColor: AppColors.primaryColor.withOpacity(0.8),
          surfaceTintColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0.r),
                  child: Signature(
                    controller: deliveryViewModel.signatureController,
                    height: 300,
                    backgroundColor: Colors.white,
                  ),
                ),
                dialogButtons(deliveryViewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget dialogButtons(DeliveryFormViewModel deliveryFormViewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.sp),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
                title: "Reject",
                bgColor: AppColors.redColor,
                onPressed: () {
                  CustomNavigation().pop();
                }),
          ),
          34.horizontalSpace,
          Expanded(
            child: CustomButton(
                title: "Accept",
                bgColor: AppColors.greenColor,
                onPressed: () async {
                  await deliveryFormViewModel.saveSignatureValue();

                  CustomNavigation().pop();
                }),
          ),
        ],
      ),
    );
  }
}
