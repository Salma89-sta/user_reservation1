import 'package:flutter/material.dart';
import 'package:Reservation/core/cache_helper/cache_helper.dart';
import 'package:Reservation/features/home/business_layer/user_reservations_cubit.dart';
import 'package:Reservation/features/home/view/home_screen.dart';
import '../../../colors/app_colors.dart';
import '../../../common/button.dart';
import '../../../common/text-form-field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../sign-up/view/signup.dart';
import '../business_layer/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginWithGoogle extends StatefulWidget {
  const loginWithGoogle({super.key});


  @override
  State<loginWithGoogle> createState() => _loginWithGoogleState();
}

class _loginWithGoogleState extends State<loginWithGoogle> {
   Widget buttonWidget= Text("تسجيل الدخول", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),);
   final FirebaseAuth _auth = FirebaseAuth.instance;

  bool passwordVisible = false;
  bool isSecure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final passwordFocusNode = FocusNode();
  bool userFound = false;

  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, LoginState>(
          listener: (context, state) async {
        if (state is LoginSuccess) {




          clearControllers();
          Fluttertoast.showToast(msg: "اهلابك! تم تسجيل الدخول بنجاح", textColor: Colors.white, backgroundColor: AppColors.litePurple);
         print(CacheHelper.getData(key: "id"));
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => BlocProvider(
  create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: "id")),
  child:const HomeScreen(),
)
          ));
          print("Login Success");
        } else if (state is LoginError) {
          Fluttertoast.showToast(msg: "برجاء التاكد من البيانات",textColor: Colors.white, backgroundColor: AppColors.litePurple);
          buttonWidget= Text("تسجيل الدخول", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),);
          print("Login error");
        } else if (state is LoginNotAcceptedYet) {
          buttonWidget= Text("تسجيل الدخول", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),);

          Fluttertoast.showToast(msg: "لم يتم قبول حسابك بعد برجاء الانتظار",textColor: Colors.white, backgroundColor:AppColors.litePurple);
        }else if (state is LoginLoading) {
          buttonWidget= const CircularProgressIndicator();}
      }, builder: (context, state) {
          return Container(
            alignment: AlignmentDirectional.centerEnd,
            width: 100.w,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(right: 5.w, top: 3.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10.w, bottom: 1.5.h),
                      alignment: AlignmentDirectional.bottomEnd,
                      child:const Text(
                        "البريد الالكتروني",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.indigo,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: TextFormFieldWidget(
                        validator:  (String? text){
                          if(_emailController.text.trim() == ''){
                            return 'This Field is Required.';
                          }
                        },
                        labelText: "",
                        suffix:const Icon(
                          Icons.email_outlined,
                          color: AppColors.lightGrey,
                        ),
                        IsObsecure: false,
                        textFieldController: _emailController,
                        color: AppColors.lightGrey,
                        fillcolor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(right: 10.w, bottom:1.5.h),
                      alignment: AlignmentDirectional.bottomEnd,
                      child:const Text(
                        "كلمة السر",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.indigo,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                     // SizedBox(height: 1.5.h),
                    TextFormFieldWidget(
                      labelText: "",
                      suffix: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.lock_open
                              : Icons.lock_outline,
                          color: AppColors.lightGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            isSecure = !isSecure;
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      prefix: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.lightGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            isSecure = !isSecure;
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      IsObsecure: isSecure,
                      textFieldController: _passwordController,
                      fillcolor: Colors.transparent,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Button0(
                      widget: Center(
                        child: buttonWidget,
                      ),
                      function: () {
                        if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                          final loginCubit = AuthCubit.get(context);
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          loginCubit.userLogin(
                            email: email,
                            password: password
                          );
                        }else{
                          Fluttertoast.showToast(msg: "برجاء ملئ جميع البيانات", textColor: Colors.white, backgroundColor:AppColors.litePurple);
                        }
                      }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: InkWell(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupScreen())),
                          child: Text(
                            "هل تريد انشاء حساب ؟",
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                // decoration: TextDecoration.underline,
                                fontSize: 18.sp),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
      }),
    );
  }
}
