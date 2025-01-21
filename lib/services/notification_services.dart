import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationController.instance.setupNotification();
  await NotificationController.instance.showNotification(message);
}

class NotificationController {
  NotificationController._();
  static final NotificationController instance = NotificationController._();
  final _messaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalMessagingInitialized = false;
  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Request permission
    await _requestpermission();
    // Setup message handler
    await _setupMessageHandler();
    // Get FCM token
    final token = await _messaging.getToken();
    print('FCM Token $token');
  }

  Future<void> _requestpermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    print('Permission status ${settings.authorizationStatus}');
  }

  Future<void> setupNotification() async {
    if (_isFlutterLocalMessagingInitialized) {
      return;
    }
    //android setup
    const channel = AndroidNotificationChannel(
        'high_importance_channel', 'High Importance Notifications',
        description: 'This channel is used for importance notifications!',
        importance: Importance.high);
    await _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    //flutter local notification
    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
    _isFlutterLocalMessagingInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              'high_importance_channel', 'High Importance Notifications',
              channelDescription:
                  'This channel is used for importance notifications!',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher'),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandler() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
    //background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    //open app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage((initialMessage));
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      //open chat screen
    }
  }
}
