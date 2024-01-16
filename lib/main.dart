import 'package:flutter/material.dart';
import 'package:rservation_user/core/network/my_http.dart';
import 'package:rservation_user/features/categories/business_layer/categories_cubit.dart';
import 'package:rservation_user/features/login/business_layer/login_cubit.dart';
import 'package:rservation_user/features/user_update_data/business_layer/user_update_data_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late SharedPreferences sharedPreferences;
late bool internetChecker;


Future<void> main() async {
  // Bloc.observer = MyBlocObserver();

  MyDio.init();
  SharedPreferences sharedPreferences;

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(
      Directionality(
          textDirection: TextDirection.rtl,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) =>  CategoryCubit()..getCategories()),
              BlocProvider(create: (context) =>  UserUpdateDataCubit()),

            ],
            child: MyApp(),
          ))
  );
}

init() async {
  sharedPreferences = await SharedPreferences.getInstance();
}
