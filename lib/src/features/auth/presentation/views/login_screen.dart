import 'package:ezy_pod/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:ezy_pod/src/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  final AutoDisposeChangeNotifierProvider<LoginViewModel>
      loginViewModelProvider =
      ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
    return LoginViewModel();
  });

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await loginViewModel.login();
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
