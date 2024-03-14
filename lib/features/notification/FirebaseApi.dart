import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../core/cache_helper/cache_helper.dart';


class FirebaseApi {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance ;

  // final android = const AndroidNotificationChannel(
  //   "channel1",
  //   "channel1" ,
  //   description: "this channel is used for important notification" ,
  //   importance: Importance.defaultImportance
  // );
  final localNotifications = FlutterLocalNotificationsPlugin();


  Future<void> handleBackgroundMessage(RemoteMessage? message) async{}

  Future<void> NotificationInitialization()async{
    await firebaseMessaging.requestPermission();
    final token = await firebaseMessaging.getToken();
    print(token);
    CacheHelper.saveData(key: 'fcmToken', value: token);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void handleMessage(RemoteMessage? message/*,context*/){
    if (message == null)
      return;
    //
    // navigationKey.currentState?.pushNamed(
    //   TestPage.route ,
    //   arguments: message
    // );
  }

  Future initPushNotification(context) async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true ,
      badge: true ,
      sound: true
    );

    FirebaseMessaging.instance.getInitialMessage().then((message){
      handleMessage(message/*, context*/);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message/*, context*/);
      });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message){
      final notification = message.notification ;
      if(notification == null)
        return;

      localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          // android: AndroidNotificationDetails(
          //   // _androidChannel.id ,
          //   // _androidChannel.name ,
          //   // channelDescription: _androidChannel.description ,
          //   // icon: "@drawable/ic launcher"
          // )
        ),
        payload: jsonEncode(message.toMap())
      );
    });
  }
}