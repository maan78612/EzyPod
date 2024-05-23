import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/core/enums/delivery_status.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_viewmodel.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/buttons.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_app_bar.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryScreen extends ConsumerWidget {
  final DeliveryStatus deliveryStatus;
  final int listLength;

  DeliveryScreen(
      {super.key, required this.listLength, required this.deliveryStatus});

  final deliveryViewModelProvider =
      ChangeNotifierProvider<DeliveryViewModel>((ref) {
    return DeliveryViewModel(ref);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryViewModel = ref.watch(deliveryViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar.deliveryAppBar(title: deliveryStatus.name),
      body: Column(
        children: [
          DeliveryList(
            listLength: listLength,
            deliveryStatus: deliveryStatus,
            deliveryViewModelProvider: deliveryViewModelProvider,
          ),
          const Spacer(),
          DeliveryListButton(
              deliveryViewModel: deliveryViewModel, listLength: listLength),
          80.verticalSpace,
        ],
      ),
    );
  }
}
