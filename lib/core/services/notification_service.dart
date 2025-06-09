import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/notifications/domain/models/notification_model.dart';
import '../../features/notifications/presentation/bloc/notification_bloc.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Channel IDs
  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'High Importance Notifications';
  static const String _channelDescription =
      'This channel is used for important notifications.';

  late final NotificationBloc _notificationBloc;

  void setBloc(NotificationBloc bloc) {
    _notificationBloc = bloc;
  }

  Future<void> initialize() async {
    // Request notification permissions
    await _requestPermissions();

    // Initialize Firebase Messaging
    await Firebase.initializeApp();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle when notification is clicked while app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Check if app was launched from a notification
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }

    // Get FCM token
    final token = await _firebaseMessaging.getToken();
    print('FCM Token: $token'); // TODO: Send this token to your server

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print(
          'FCM Token refreshed: $newToken'); // TODO: Update token on your server
    });
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      if (status.isDenied) {
        debugPrint('Notification permissions denied');
      }
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // Handle iOS local notification when app is in foreground
      },
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // Handle notification tap
        if (details.payload != null) {
          final Map<String, dynamic> data = json.decode(details.payload!);
          _handleNotificationTap(data);
        }
      },
    );

    // Create the notification channel for Android
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              _channelId,
              _channelName,
              description: _channelDescription,
              importance: Importance.high,
            ),
          );
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Handling foreground message: ${message.messageId}');
    await _showLocalNotification(message);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body,
      details,
      payload: json.encode(message.data),
    );
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      _handleNotificationTap(message.data);
    }
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    // Handle notification tap based on the data
    // You can implement navigation or other actions here
    debugPrint('Notification tapped with data: $data');
  }

  void _handleInitialMessage(RemoteMessage message) {
    print('App launched from notification: ${message.messageId}');
    _saveNotification(message);
    // TODO: Handle navigation based on message data
  }

  void _saveNotification(RemoteMessage message) {
    if (message.notification != null) {
      final notification = NotificationModel(
        id: message.messageId ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: message.notification?.title ?? 'New Notification',
        body: message.notification?.body ?? '',
        timestamp: message.sentTime ?? DateTime.now(),
        data: message.data,
      );

      _notificationBloc.add(AddNotification(notification));
    }
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling background message: ${message.messageId}');
  // Don't show local notification here as it's handled by the system automatically
}
