import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/colors/app_colors.dart';

class Button0 extends StatelessWidget {
  final Widget widget;
  final function;

   const Button0({Key? key, required this.widget, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      height: 8.h,
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(20)
      ),
      child: InkWell(
        onTap:function,
        child: widget,
      ),
    );
  }
}
