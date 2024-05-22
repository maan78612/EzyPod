import 'package:ezy_pod/src/core/constants/globals.dart';
import 'package:ezy_pod/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ezy_pod/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel with ChangeNotifier {
  final Ref _ref;

  LoginViewModel(this._ref);

  final AuthRepository _authRepository = AuthRepositoryImpl();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController tenantCon = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isBtnEnable = false;

  bool get isLoading => _isLoading;

  bool get isBtnEnable => _isBtnEnable;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setEnableBtn() {
    if (emailCon.text.isNotEmpty && passwordCon.text.isNotEmpty) {
      _isBtnEnable = true;
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
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
}
