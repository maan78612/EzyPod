import 'package:ezy_pod/src/core/constants/globals.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FBNotificationManager extends StatefulWidget {
  final Widget page;

  const FBNotificationManager({super.key, required this.page});

  @override
  State<StatefulWidget> createState() => _FBNotificationWrapper();
}

class _FBNotificationWrapper extends State<FBNotificationManager> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _firebaseMessaging = FirebaseMessaging.instance;

  /// Set channel for Android
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notifications",
      importance: Importance.max, showBadge: true);

  /// Set Flutter local notification details
  final notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      channel.id,
      channel.name,
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

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
      await initializeFlutterLocalNotifications();

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

      await showNotification(message.hashCode, message.notification?.title,
          message.notification?.body);

      debugPrint(
          "Message on [APP Background or Foreground] ${message.notification?.title}");
    });
  }

  Future<void> showNotification(int id, String? title, String? body) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      "$title",
      body,
      notificationDetails,
    );
  }

  /*========= initialization of Flutter Local Notifications=========*/
  Future<void> initializeFlutterLocalNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/notification_icon');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
