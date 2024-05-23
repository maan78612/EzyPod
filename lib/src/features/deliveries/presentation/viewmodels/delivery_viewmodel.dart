import 'package:ezy_pod/src/features/deliveries/data/repositories/delivery_repository_impl.dart';
import 'package:ezy_pod/src/features/deliveries/domain/repositories/delivery_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signature/signature.dart';

class DeliveryViewModel with ChangeNotifier {
  final Ref _ref;
  final DeliveryRepository _deliveryRepository = DeliveryRepositoryImpl();

  DeliveryViewModel(this._ref);

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
  TextEditingController notes = TextEditingController();

/*=================Delivery Form Screen =====================*/

  final _signatureController = SignatureController();
  Uint8List? _signatureBytes;

  SignatureController get signatureController => _signatureController;

  Uint8List? get signatureBytes => _signatureBytes;

  void clearSignaturePad() {
    _signatureBytes = null;
    _signatureController.clear();
    notifyListeners();
  }

  Future<void> saveSignatureValue() async {
    final bytes = await _signatureController.toPngBytes();

    _signatureBytes = bytes;

    notifyListeners();
  }
}
