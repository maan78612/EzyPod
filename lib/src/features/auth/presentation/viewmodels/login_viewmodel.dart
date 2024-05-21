import 'package:ezy_pod/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../data/repositories/auth_repository_impl.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  bool isLoading = false;

  setLoading(bool loading) {
    isLoading = loading;
  }

  Future<void> login() async {
    setLoading(true);
    try {
      final user = await _authRepository.login(username: '', password: '');
    } catch (e) {
      // Handle login error
      if (kDebugMode) {
        print('Login error: $e');
      }
    } finally {
      setLoading(false);
    }
  }
}
