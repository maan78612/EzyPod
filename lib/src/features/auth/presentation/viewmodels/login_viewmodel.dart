import 'package:ezy_pod/src/core/globals.dart';
import 'package:ezy_pod/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ezy_pod/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel with ChangeNotifier {
  final Ref _ref;
  final AuthRepository _authRepository = AuthRepositoryImpl();

  LoginViewModel(this._ref);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> login() async {
    setLoading = true;
    try {
      final user = await _authRepository.login(username: '', password: '');
      _ref.read(userProvider.notifier).update((state) => user);
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
