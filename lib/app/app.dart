import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/features/categories/business_layer/categories_cubit.dart';
import 'package:rservation_user/features/home/business_layer/user_reservations_cubit.dart';
import 'package:rservation_user/features/login/business_layer/login_cubit.dart';
import 'package:rservation_user/features/login/view/login.dart';


class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LogIn(),
        );
      },
    );
  }

}
