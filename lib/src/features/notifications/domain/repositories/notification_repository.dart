import 'package:ezy_pod/src/features/notifications/domain/models/notifications.dart';

abstract class NotificationRepository {
  Future<Notifications> fetchNotifications();
}
