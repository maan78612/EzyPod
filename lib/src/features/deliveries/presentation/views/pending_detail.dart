import 'package:ezy_pod/src/core/commons/custom_button.dart';
import 'package:ezy_pod/src/core/commons/custom_navigation.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/images.dart';
import 'package:ezy_pod/src/features/deliveries/domain/models/address_model.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_viewmodel.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/delivery_form/delivered_form.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/delivery_form/undelivered_form.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_app_bar.dart';
import 'package:ezy_pod/src/features/home/domain/models/deliveries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PendingDetailScreen extends ConsumerWidget {
  final ChangeNotifierProvider<DeliveryViewModel> deliveryViewModelProvider;
  final DeliveriesResult delivery;
  final AddressResult address;

  const PendingDetailScreen(
      {super.key,
      required this.deliveryViewModelProvider,
        required this.address,
      required this.delivery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryViewModel = ref.watch(deliveryViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar.deliveryAppBar(title: "Delivery ${delivery.id}"),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: ListView(
          children: [
            infoTile1(title: 'Name', value: 'MR Jones', img: AppImages.user),
            infoTile1(
                title: 'Address1',
                value: address.address1,
                img: AppImages.location),
            infoTile1(
                title: 'Address2',
                value: address.address2,
                img: AppImages.location),
            infoTile1(title: 'City', value: address.city, img: AppImages.city),
            infoTile1(title: 'Vehicle', value: 'BB4 6HG', img: AppImages.truck),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                infoTile2(title: 'Open in Maps', img: AppImages.location),
                const Spacer(),
                infoTile2(title: '9898989898', img: AppImages.phone),
                const Spacer(),
              ],
            ),
            32.verticalSpace,
            notesField(deliveryViewModel),
            buttons(deliveryViewModel)
          ],
        ),
      ),
    );
  }

  Widget buttons(DeliveryViewModel deliveryViewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.sp),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
                title: "Delivered",
                bgColor: AppColors.primaryColor,
                onPressed: () {
                  CustomNavigation().push(DeliveredForm());
                }),
          ),
          34.horizontalSpace,
          Expanded(
            child: CustomButton(
                title: "Undelivered",
                bgColor: AppColors.redColor,
                onPressed: () {
                  CustomNavigation().push(UndeliveredForm());
                }),
          ),
        ],
      ),
    );
  }

  Widget notesField(DeliveryViewModel deliveryViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notes",
            style: InterStyles.medium
                .copyWith(fontSize: 14.sp, color: AppColors.lightTextColor)),
        11.verticalSpace,
        TextFormField(
          cursorColor: AppColors.primaryColor,
          controller: deliveryViewModel.notes,
          enabled: false,
          style: InterStyles.regular.copyWith(fontSize: 14.sp),
          decoration: InputDecoration(
            // hintText: 'Please Enter Note',
            // hintStyle: InterStyles.regular,
            border: inputBorder,
            enabledBorder: inputBorder,
            errorBorder: inputBorder,
            focusedBorder: inputBorder.copyWith(
                borderSide: BorderSide(
              color: AppColors.focusedBorderColor,
            )),
            disabledBorder: inputBorder,
          ),
          maxLines: 12, // Optional, for multi-line input
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

  Widget infoTile1(
      {required String title, required String value, required String img}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.sp),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5.0.sp),
            child: SvgPicture.asset(img, height: 20.sp),
          ),
          5.horizontalSpace,
          Text(
            "$title : $value",
            style: InterStyles.medium
                .copyWith(fontSize: 16.sp, color: AppColors.blackColor),
          ),
        ],
      ),
    );
  }

  Widget infoTile2({required String title, required String img}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5.0.sp),
          child: SvgPicture.asset(img, height: 15.sp),
        ),
        5.horizontalSpace,
        Text(
          title,
          style: InterStyles.regular
              .copyWith(fontSize: 12.sp, color: AppColors.blackColor),
        ),
      ],
    );
  }
}
