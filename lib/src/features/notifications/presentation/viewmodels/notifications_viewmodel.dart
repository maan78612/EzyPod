import 'package:ezy_pod/src/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:ezy_pod/src/features/notifications/domain/repositories/notification_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationsViewModel with ChangeNotifier {
  final NotificationRepository _notificationRepository =
      NotificationRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchNotificationData() async {
    setLoading = true;
    try {
      await _notificationRepository.fetchNotifications();
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
