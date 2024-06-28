import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Reservation/colors/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/features/sign-up/view/signup-form-widget.dart';


class SignupScreen extends StatefulWidget {

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
          child: Column(
            children: [
              // Container(
              //   width: 100.w,
              //   height: 30.h,
              //   decoration: BoxDecoration(
              //     gradient: AppColors.buttonGradient,
              //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
              //   ),
              //   child: Column(
              //     children: [
              //
              //      const SizedBox(height: 20,),
              //       const Center(
              //         child: Text("انشاء حساب جديد", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Cairo', color:Colors.white ),),
              //       ),
              //
              //       // SizedBox(height: 50,),
              //
              //       // Image.asset("assets/images/login.png", width: 100.w, height: 20.h,),
              //
              //     ],
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                    gradient: AppColors.buttonGradient,
                ),
                width: 100.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      const SizedBox(height: 20,),

                      Text("انشاء حساب جديد", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp, fontFamily: 'Cairo', color:Colors.white ),),

                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                          decoration:const BoxDecoration(
                              color: Colors.white,
                              // gradient: AppColors.buttonGradient,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50) )
                          ),
                          child: Center(child: SignupFormWidget())),
                    ],
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}

