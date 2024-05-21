import 'package:ezy_pod/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:ezy_pod/src/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel with ChangeNotifier {
  final Ref _ref;
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  HomeViewModel(this._ref);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchDeliveryData() async {
    setLoading = true;
    try {
      final data = await _homeRepository.fetchDeliveries();
    } catch (e) {
      // Handle login error
      if (kDebugMode) {
        print('Login error: $e');
      }
    } finally {
      setLoading = false;
    }
  }
}
