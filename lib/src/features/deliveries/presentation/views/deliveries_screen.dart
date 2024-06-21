import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/features/deliveries/domain/models/address_model.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_viewmodel.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/buttons.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_app_bar.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_list.dart';
import 'package:ezy_pod/src/features/home/domain/models/deliveries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryScreen extends ConsumerStatefulWidget {
  final String appTitle;
  final List<DeliveriesResult> deliveriesList;
  final List<AddressResult> addresses;

  const DeliveryScreen(
      {super.key,
      required this.deliveriesList,
      required this.appTitle,
      required this.addresses});

  @override
  ConsumerState<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends ConsumerState<DeliveryScreen> {
  final deliveryViewModelProvider =
      ChangeNotifierProvider<DeliveryViewModel>((ref) {
    return DeliveryViewModel();
  });

  @override
  void initState() {
    ref.read(deliveryViewModelProvider).init(
        deliveriesList: widget.deliveriesList, addresses: widget.addresses);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryViewModel = ref.watch(deliveryViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar.deliveryAppBar(title: widget.appTitle),
      body: Column(
        children: [
          DeliveryList(
            deliveriesList: deliveryViewModel.deliveriesList,
            deliveryViewModelProvider: deliveryViewModelProvider,
          ),
          const Spacer(),
          DeliveryListButton(
              deliveryViewModel: deliveryViewModel,
              listLength: deliveryViewModel.deliveriesList.length),
          80.verticalSpace,
        ],
      ),
    );
  }
}
