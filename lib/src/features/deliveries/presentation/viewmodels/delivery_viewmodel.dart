import 'package:ezy_pod/src/features/deliveries/data/repositories/delivery_repository_impl.dart';
import 'package:ezy_pod/src/features/deliveries/domain/repositories/delivery_repository.dart';
import 'package:flutter/material.dart';

class DeliveryViewModel with ChangeNotifier {
  final DeliveryRepository _deliveryRepository = DeliveryRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  int currentIndex = 0;

  void onNextClicked(int listLength) {
    if (currentIndex + 7 < listLength) {
      currentIndex += 7;
    }

    notifyListeners();
  }

  void onPreviousClicked() {
    if (currentIndex >= 7) {
      currentIndex -= 7;
    }
    notifyListeners();
  }

  int nextDataListLength(int listLength) {
    final endIndex = currentIndex + 7;
    return endIndex > listLength ? listLength - currentIndex : 7;
  }

  /*=================Pending  Detail Screen =====================*/
  TextEditingController notes = TextEditingController(
      text:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ");
}
