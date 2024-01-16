import 'package:flutter/material.dart';

class AppColors {
  static const Color lightGrey = Color(0xffcbccd0);



  static LinearGradient buttonGradient = const LinearGradient(
      colors: [Colors.white, Colors.deepOrange],
      begin: Alignment.topLeft,
      tileMode: TileMode.clamp,
      stops: [0.0, 2.0],
      end: Alignment.bottomRight);


}
