import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rservation_user/colors/app_colors.dart';
import 'package:rservation_user/common/button.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'login-form-widget.dart';

class LogIn extends StatefulWidget {
 
  @override
  State<LogIn> createState() => _LoginState();
}

class _LoginState extends State<LogIn> {
  var width, height, size ;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    size= MediaQuery.of(context).size;
    height= size.height;
    width= size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            alignment: AlignmentDirectional.centerEnd,
            child: Column(

              children: [

                Container(
                  width: 100.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradient,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(50) )
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("تسجيل الدخول", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Cairo', color: Colors.white),),
                      Image.asset("assets/images/login.png", width: 100.w, height: 180,),
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Column(
                    children: [
                       LoginFormWidget(),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

