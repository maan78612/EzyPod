import 'package:ezy_pod/src/core/commons/custom_inkwell.dart';
import 'package:ezy_pod/src/core/commons/expanded_section.dart';
import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/constants/fonts.dart';
import 'package:ezy_pod/src/core/constants/globals.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReasonsDropDown extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<DeliveryFormViewModel>
      deliveryFormViewModelProvider;

  const ReasonsDropDown(
      {super.key, required this.deliveryFormViewModelProvider});

  @override
  ConsumerState<ReasonsDropDown> createState() => _ReasonsDropDownState();
}

class _ReasonsDropDownState extends ConsumerState<ReasonsDropDown>
    with SingleTickerProviderStateMixin {
  final ScrollController statusScrollController = ScrollController();

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryFormViewModel =
        ref.watch(widget.deliveryFormViewModelProvider);
    return Column(
      children: [
        dropdownHeader(deliveryFormViewModel),
        expansionList(deliveryFormViewModel, context),
      ],
    );
  }

  Widget dropdownHeader(DeliveryFormViewModel deliveryFormViewModel) {
    return CommonInkWell(
      onTap: () {
        deliveryFormViewModel.setDropdownExpansion(_controller);
      },
      child: Container(
        height: inputFieldHeight,
        decoration: BoxDecoration(
            border: deliveryFormViewModel.showBottomBorder
                ? const Border(
                    top: BorderSide(color: AppColors.borderColor),
                    left: BorderSide(color: AppColors.borderColor),
                    right: BorderSide(color: AppColors.borderColor),
                  )
                : Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
                bottomLeft: deliveryFormViewModel.showBottomBorder
                    ? Radius.zero
                    : Radius.circular(8.r),
                bottomRight: deliveryFormViewModel.showBottomBorder
                    ? Radius.zero
                    : Radius.circular(8.r))),
        child: Row(
          children: [
            12.horizontalSpace,
            Expanded(
                child: Text(
                    deliveryFormViewModel.undeliveredReason != null
                        ? deliveryFormViewModel.undeliveredReason!
                        : "Select undelivery Reason",
                    style: InterStyles.regular.copyWith(
                        color: deliveryFormViewModel.undeliveredReason != null
                            ? AppColors.blackColor
                            : AppColors.greyColor))),
            const Icon(Icons.keyboard_arrow_down_rounded),
            12.horizontalSpace,
          ],
        ),
      ),
    );
  }

  Widget expansionList(
      DeliveryFormViewModel deliveryFormViewModel, BuildContext context) {
    return ExpandedSection(
      expand: deliveryFormViewModel.isDropdownExpanded,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
              border: const Border(
                left: BorderSide(color: AppColors.borderColor),
                right: BorderSide(color: AppColors.borderColor),
                bottom: BorderSide(color: AppColors.borderColor),
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r))),
          child: RawScrollbar(
            thumbColor: Theme.of(context).primaryColor,
            thumbVisibility: true,
            thickness: 3,
            trackVisibility: true,
            controller: statusScrollController,
            trackColor: AppColors.primaryColor,
            trackBorderColor: Colors.transparent,
            trackRadius: const Radius.circular(10),
            minThumbLength: 50,
            radius: const Radius.circular(5),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: deliveryFormViewModel.reasonsList.length,
              controller: statusScrollController,
              itemBuilder: (context, index) {
                return dropdownTile(deliveryFormViewModel, index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdownTile(DeliveryFormViewModel deliveryFormViewModel, int index) {
    return CommonInkWell(
      onTap: () {
        deliveryFormViewModel.setReasonValue(
            _controller, deliveryFormViewModel.reasonsList[index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        child: Text(deliveryFormViewModel.reasonsList[index],
            style: InterStyles.regular.copyWith(color: AppColors.blackColor)),
      ),
    );
  }
}
