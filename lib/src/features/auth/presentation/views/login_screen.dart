import 'package:ezy_pod/src/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
    return LoginViewModel(ref);
  });

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider);
    final loginViewModelNotifier = ref.watch(loginViewModelProvider.notifier);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await loginViewModelNotifier.login();
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
