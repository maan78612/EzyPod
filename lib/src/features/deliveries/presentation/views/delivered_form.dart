import 'package:ezy_pod/src/core/constants/colors.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/viewmodels/delivery_viewmodel.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/delivery_app_bar.dart';
import 'package:ezy_pod/src/features/deliveries/presentation/views/widgets/signature_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveredForm extends ConsumerWidget {
  final ChangeNotifierProvider<DeliveryViewModel> deliveryViewModelProvider;

  const DeliveredForm({super.key, required this.deliveryViewModelProvider});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar.deliveryAppBar(title: "Sign Please"),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: ListView(
          children: [
            SignaturePad(deliveryViewModelProvider: deliveryViewModelProvider),
          ],
        ),
      ),
    );
  }
}
