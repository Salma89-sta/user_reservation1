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
import 'features/notification/FirebaseApi.dart';

late SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDqG1cIa_1OHTaa8FVLTMhiqJb4h8pIVPU",
      appId: "1:422940300781:android:5d15808aa8aba65bef83e4",
      messagingSenderId: "422940300781",
      projectId: "abumosa-8b962",
    ),
  );
  await CacheHelper.init();


  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  String? token = await messaging.getToken();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  CacheHelper.saveData(key: 'fcmToken', value: fcmToken);
  // var response = await MyHttp.post(endPoint: API.notificaion, data: {
  //   'id':CacheHelper.getData(key: 'id'),
  //   "token":fcmToken,
  // });
  //
  // print(".........notification response................");
  // print(response);
  //
  // print('FCM Token: $fcmToken');


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
