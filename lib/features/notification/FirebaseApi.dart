import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('=): User granted permission: ${settings.authorizationStatus}');

    _firebaseMessaging.getToken().then((token) {
      print('=): FCM Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      AwesomeNotifications().initialize(
          "resource://drawable/res_launcher_icon",
          [
            NotificationChannel(
                channelKey: "high_importance_channel",
                channelName: "High_importance_channel",
                importance: NotificationImportance.Max,
                vibrationPattern: highVibrationPattern,
                channelShowBadge: true,
                channelDescription: "high_importance_channel"
            ),
          ]
      );
      AwesomeNotifications().isNotificationAllowed().then((value) {
        if (!value) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });

      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 0,
              channelKey: "high_importance_channel",
              title: message.notification?.title,
              body: message.notification?.body
          )
      );
      print('=): Received message: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          '=): Message opened while app is in foreground: ${message.notification
              ?.title}');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('=): Handling a background message: ${message.messageId}');
  }

}