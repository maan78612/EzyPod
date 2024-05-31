import 'package:ezy_pod/src/core/constants/globals.dart';
import 'package:ezy_pod/src/core/utilities/flutter_local_notification_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FBNotificationManager extends StatefulWidget {
  final Widget page;

  const FBNotificationManager({super.key, required this.page});

  @override
  State<StatefulWidget> createState() => _FBNotificationWrapper();
}

class _FBNotificationWrapper extends State<FBNotificationManager> {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationManager _flutterLocalNotificationManager =
      FlutterLocalNotificationManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAndSaveToken();
      await notificationInit();
    });
  }

  Future<void> fetchAndSaveToken() async {
    final token = await _firebaseMessaging.getToken();

    /// code below will update token in login api
    fcmToken = token;
    debugPrint(token);
  }

  @override
  Widget build(BuildContext context) {
    return widget.page;
  }




  Future<void> notificationInit() async {
    /// notification permission setting
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    /// check permission for notification
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      await _flutterLocalNotificationManager.onInit();

      /// To get notification on foreground and background state
      await notificationOnBackgroundAndForeground();

      /// To get notification of termination state
      await notificationOnTermination();
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  notificationOnTermination() async {
    RemoteMessage? msgOnTermination =
        await _firebaseMessaging.getInitialMessage();

    if (msgOnTermination != null) {
      debugPrint(
          "Message on [APP TERMINATED] ${msgOnTermination.notification?.body}");
    }
  }

  notificationOnBackgroundAndForeground() {
    debugPrint("test");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      /// showNotification only works when app is in foreground otherwise
      /// uses it's own push notification banner for background and termination state

      await _flutterLocalNotificationManager.showNotification(message.hashCode,
          message.notification?.title, message.notification?.body);

      debugPrint(
          "Message on [APP Background or Foreground] ${message.notification?.title}");
    });
  }
}
