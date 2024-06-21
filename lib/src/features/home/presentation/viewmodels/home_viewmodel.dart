import 'package:ezy_pod/src/features/deliveries/domain/models/address_model.dart';
import 'package:ezy_pod/src/features/home/domain/models/deliveries.dart';
import 'package:ezy_pod/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:ezy_pod/src/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  DeliveriesModel? deliveryData;
  List<AddressResult> addressList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> onInit() async {
    try {
      setLoading = true;
      await fetchDeliveryData();
      await fetchAddressData();
    } catch (e) {
      debugPrint('fetchDeliveryData error: $e');
    } finally {
      setLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchDeliveryData() async {
    try {
      deliveryData = await _homeRepository.fetchDeliveries();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchAddressData() async {
    try {
      addressList = await _homeRepository.fetchAddress();
    } catch (e) {
      rethrow;
    }
  }
}
