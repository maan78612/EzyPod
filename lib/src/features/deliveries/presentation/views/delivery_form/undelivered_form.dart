
import 'package:ezy_pod/src/core/commons/custom_button.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/enums/snackbar_status.dart';
import 'package:ezy_pod/src/core/utilities.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_form_viewmodel.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_app_bar.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/resons_dropdown.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UndeliveredForm extends ConsumerWidget {
  final deliveryFormViewModelProvider =
      ChangeNotifierProvider<DeliveryFormViewModel>((ref) {
    return DeliveryFormViewModel(ref);
  });

  UndeliveredForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryFormViewModel = ref.watch(deliveryFormViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar.deliveryAppBar(title: "Undelivered Reason"),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: ListView(
          children: [
            UploadImageCard(
                deliveryFormViewModelProvider: deliveryFormViewModelProvider),
            24.verticalSpace,
            ReasonsDropDown(
                deliveryFormViewModelProvider: deliveryFormViewModelProvider),
            24.verticalSpace,
            notesField(deliveryFormViewModel),
            24.verticalSpace,
            CustomButton(
                title: "Undelivered",
                bgColor: AppColors.redColor,
                onPressed: () {
                  deliveryFormViewModel.undelivered(
                      showSnackBarMsg: ({
                    required SnackBarType snackType,
                    required String message,
                  }) =>
                          Utils.customSnackBar(message, snackType, context));
                }),
          ],
        ),
      ),
    );
  }

  Widget notesField(DeliveryFormViewModel deliveryFormViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notes",
            style: InterStyles.medium
                .copyWith(fontSize: 14.sp, color: AppColors.lightTextColor)),
        11.verticalSpace,
        TextFormField(
          cursorColor: AppColors.primaryColor,
          controller: deliveryFormViewModel.notes,

          style: InterStyles.regular.copyWith(fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: 'Enter here...',
            hintStyle: InterStyles.regular,
            border: inputBorder,
            enabledBorder: inputBorder,
            errorBorder: inputBorder,
            focusedBorder: inputBorder.copyWith(
                borderSide: BorderSide(
              color: AppColors.focusedBorderColor,
            )),
            disabledBorder: inputBorder,
          ),
          maxLines: 15, // Optional, for multi-line input
        ),
      ],
    );
  }

  InputBorder get inputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.r),
      borderSide: BorderSide(
        color: AppColors.borderColor,
        width: 1.sp,
      ),
    );
  }
}
