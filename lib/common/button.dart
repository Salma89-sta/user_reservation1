import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/colors/app_colors.dart';

class Button0 extends StatelessWidget {
  final Widget widget;
  final  function;

   Button0({Key? key, required this.widget, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 10.h,
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
