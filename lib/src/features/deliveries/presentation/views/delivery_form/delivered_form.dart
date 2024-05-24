import 'package:ezy_pod/src/core/commons/custom_button.dart';
import 'package:ezy_pod/src/core/commons/custom_input_field.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/core/constants/text_field_validator.dart';
import 'package:ezy_pod/src/core/enums/snackbar_status.dart';
import 'package:ezy_pod/src/core/utilities.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_form_viewmodel.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_app_bar.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/signature_pad.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeliveredForm extends ConsumerWidget {
  DeliveredForm({super.key});

  final deliveryFormViewModelProvider =
      ChangeNotifierProvider<DeliveryFormViewModel>((ref) {
    return DeliveryFormViewModel(ref);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryFormViewModel = ref.watch(deliveryFormViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar.deliveryAppBar(title: "Sign Please"),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: ListView(
          children: [
            SignaturePad(
                deliveryFormViewModelProvider: deliveryFormViewModelProvider),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.sp),
              child: CustomInputField(
                controller: deliveryFormViewModel.personNameCon,
                title: "Person Name",
                hint: "Enter person name",
              ),
            ),
            UploadImageCard(
                deliveryFormViewModelProvider: deliveryFormViewModelProvider),
            checkBoxWidget(deliveryFormViewModel),
            notesField(deliveryFormViewModel),
            24.verticalSpace,
            CustomButton(
                title: "Submit Delivery",
                bgColor: AppColors.greenColor,
                onPressed: () {
                  deliveryFormViewModel.submit(
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

  Widget checkBoxWidget(DeliveryFormViewModel deliveryFormViewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: deliveryFormViewModel.isCheckBox,
            side: const BorderSide(color: AppColors.borderColor),
            activeColor: AppColors.primaryColor,
            onChanged: (value) {
              deliveryFormViewModel.setCheckBox(value);
            },
            visualDensity: VisualDensity.compact,
          ),
          Text(
            'Left at Neighbour ',
            style: InterStyles.medium
                .copyWith(fontSize: 14.sp, color: AppColors.blackColor),
          ),
        ],
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
          maxLines: 5, // Optional, for multi-line input
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
