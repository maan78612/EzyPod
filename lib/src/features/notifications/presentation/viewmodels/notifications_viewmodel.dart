import 'package:ezy_pod/src/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:ezy_pod/src/features/notifications/domain/repositories/notification_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsViewModel with ChangeNotifier {
  final Ref _ref;
  final NotificationRepository _notificationRepository =
      NotificationRepositoryImpl();

  NotificationsViewModel(this._ref);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchNotificationData() async {
    setLoading = true;
    try {
      final data = await _notificationRepository.fetchNotifications();
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
