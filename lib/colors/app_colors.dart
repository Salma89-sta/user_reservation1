import 'package:flutter/material.dart';

class AppColors {
  static const Color lightGrey = Color(0xffcbccd0);
  static const Color darkPurple = Color.fromRGBO(189, 23, 53, 1);
  static const Color litePurple = Color.fromRGBO(44, 25, 55, 1);



  static LinearGradient buttonGradient = const LinearGradient(
      colors: [Color.fromRGBO(189, 23, 53, 1), Color.fromRGBO(44, 25, 55, 1)],
      begin: Alignment.topLeft,
      tileMode: TileMode.clamp,
      // stops: [0.0, 2.0],
      end: Alignment.topRight);


}
