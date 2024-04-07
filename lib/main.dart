import 'package:flutter/material.dart';
import 'package:Reservation/core/network/my_http.dart';
import 'package:Reservation/features/categories/business_layer/categories_cubit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:Reservation/features/user_update_data/business_layer/user_update_data_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'core/cache_helper/cache_helper.dart';

late SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAhSg_byva15u1EiiGNgnFVPGewGp8fHXQ",
      appId: "1:837880744926:android:5d6d1cbca160402feeeb4f",
      messagingSenderId: "422940300781",
      projectId: "abumusa-57a7e",
    ),
  );
  await CacheHelper.init();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  print(".......................................");

  print(messaging);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  CacheHelper.saveData(key: 'fcmToken', value: fcmToken);


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  MyDio.init();
  EasyLoading.init();
  await initializeDateFormatting();

  runApp(
    Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CategoryCubit()..getCategories()),
          BlocProvider(create: (context) => UserUpdateDataCubit()),
        ],
        child: MyApp(),
      ),
    ),
  );
}
