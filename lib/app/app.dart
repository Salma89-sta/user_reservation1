import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/features/login/view/login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/cache_helper/cache_helper.dart';
import '../features/home/business_layer/user_reservations_cubit.dart';
import '../features/home/view/home_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            iconTheme: IconThemeData(color: Colors.white),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // home: LogIn(),
          home: CacheHelper.getData(key: "id") == null
              ?
          LogIn()
              :
          BlocProvider(
            create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: "id")),
            child:HomeScreen(),
          ),
        );
      },
    );
  }

}
