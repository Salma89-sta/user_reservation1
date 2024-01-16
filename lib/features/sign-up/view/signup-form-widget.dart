import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rservation_user/features/home/view/home_screen.dart';
import 'package:rservation_user/features/sign-up/business_layer/signup_cubit.dart';
import '../../../colors/app_colors.dart';
import '../../../common/button.dart';
import '../../../common/snack_bar_widget.dart';
import '../../../common/text-form-field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../login/view/login.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({Key? key}) : super(key: key);

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {

  bool passwordVisible = false;
  bool isSecure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =new TextEditingController();
  final TextEditingController _phoneController =new TextEditingController();
  final TextEditingController _nameController =new TextEditingController();
  final TextEditingController _nationalIdController =new TextEditingController();
  final TextEditingController _passwordController =new TextEditingController();
  final TextEditingController _passwordConfirmController =new TextEditingController();


  final passwordFocusNode = FocusNode();
  bool userFound = false;

  Widget buttonWidget= Text("تسجيل الدخول", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),);

  void clearControllers() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _nationalIdController.clear();
    _phoneController.clear();
    _passwordConfirmController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            SignupCubit(),
        child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupError) {
                Fluttertoast.showToast(msg: "حدث خطا اثناء تسجيل البيانات",textColor: Colors.white, backgroundColor: Colors.deepOrange);
                buttonWidget= Text("تسجيل الدخول", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),);
                print("Signup error");

              } else if (state is SignupDublicate) {
                buttonWidget= Text("تسجيل الدخول", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),);
                Fluttertoast.showToast(msg: "البريد الالكتروني موجود بالفعل ",textColor: Colors.white, backgroundColor: Colors.deepOrange);


              } else if (state is SignupSuccess) {
                Fluttertoast.showToast(msg: "تم ارسال طلبك برجا انتظر الموافقه ",textColor: Colors.white, backgroundColor: Colors.deepOrange);


              }else if(state is SignupLoading){
                buttonWidget =CircularProgressIndicator();

              }
            },
            builder: (context, state) {
              return Container(
                width: 100.w,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10.w),
                            alignment: AlignmentDirectional.bottomEnd,
                            child: const Text(
                              " الاسم",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child: TextFormFieldWidget(
                              labelText: "",
                              // prefix: null,
                              suffix: const Icon(
                                Icons.people_outline_rounded,
                                color: AppColors.lightGrey,
                              ),
                              IsObsecure: false,
                              textFieldController: _nameController,
                              color: AppColors.lightGrey,
                              fillcolor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15,),


                          Container(
                            padding: EdgeInsets.only(right: 10.w),
                            alignment: AlignmentDirectional.bottomEnd,
                            child: const Text(
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
                          SizedBox(height: 10,),
                          Container(
                            child: TextFormFieldWidget(
                              labelText: "",
                              // prefix: null,
                              suffix: const Icon(
                                Icons.email_outlined,
                                color: AppColors.lightGrey,
                              ),
                              IsObsecure: false,
                              textFieldController: _emailController,
                              color: AppColors.lightGrey,
                              fillcolor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15,),


                          Container(
                            padding: EdgeInsets.only(right: 10.w),
                            alignment: AlignmentDirectional.bottomEnd,
                            child: const Text(
                              "رقم الهاتف",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),

                          Container(
                            child: TextFormFieldWidget(
                              labelText: "",
                              // prefix: null,
                              suffix: const Icon(
                                Icons.phone,
                                color: AppColors.lightGrey,
                              ),
                              IsObsecure: false,
                              textFieldController: _phoneController,
                              color: AppColors.lightGrey,
                              fillcolor: Colors.white,
                            ),
                          ),


                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.only(right: 10.w),
                            alignment: AlignmentDirectional.bottomEnd,
                            child: const Text(
                              "الرقم القومي",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child: TextFormFieldWidget(
                              labelText: "",
                              suffix: const Icon(
                                Icons.note,
                                color: AppColors.lightGrey,
                              ),
                              IsObsecure: false,
                              textFieldController: _nationalIdController,
                              color: AppColors.lightGrey,
                              fillcolor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15,),


                          Container(
                            padding: EdgeInsets.only(right: 10.w),
                            alignment: AlignmentDirectional.bottomEnd,
                            child: const Text(
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
                          SizedBox(height: 10),
                          TextFormFieldWidget(
                            labelText: "",
                            prefix: IconButton(
                              icon: Icon(
                                passwordVisible ? Icons.lock_open : Icons
                                    .lock_outline,
                                color: AppColors.lightGrey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSecure = !isSecure;
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            suffix: IconButton(
                              icon: Icon(
                                passwordVisible ? Icons.visibility : Icons
                                    .visibility_off,
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

                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.only(right: 10.w),
                            alignment: AlignmentDirectional.bottomEnd,
                            child: const Text(
                              "تأكيد كلمه السر",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormFieldWidget(

                            labelText: "",
                            prefix: IconButton(
                              icon: Icon(
                                passwordVisible ? Icons.lock_open : Icons
                                    .lock_outline,
                                color: AppColors.lightGrey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSecure = !isSecure;
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            suffix: IconButton(
                              icon: Icon(
                                passwordVisible ? Icons.visibility : Icons
                                    .visibility_off,
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
                            textFieldController: _passwordConfirmController,
                            fillcolor: Colors.transparent,
                            color: Colors.white,
                          ),

                          SizedBox(height: 30,),
                          Button0(widget: Center(child:buttonWidget),
                              function: () {

                            if(_emailController.text.trim().isNotEmpty  && _nationalIdController.text.trim().isNotEmpty
                                && _passwordController.text.trim().isNotEmpty && _nameController.text.trim().isNotEmpty  )
                              {
                                print(_emailController.text);
                                if (_passwordController.text.trim() ==
                                    _passwordConfirmController.text.trim()) {
                                  final signupCubit = SignupCubit.get(context);
                                  signupCubit.userSignup(
                                      _nameController.text.trim(),
                                      _emailController.text.trim(),
                                      _phoneController.text.trim(),
                                      _passwordController.text.trim(),
                                      _nationalIdController.text.trim()
                                  );
                                } else {
                                  Fluttertoast.showToast(msg: "كلمه السر ليست متطابقه",textColor: Colors.white, backgroundColor: Colors.deepOrange);
                                }
                              }else{
                              Fluttertoast.showToast(msg: "برجاء ملئ جميع البيانات",textColor: Colors.white, backgroundColor: Colors.deepOrange);

                            }


                              }),
                          SizedBox(height: 30,),
                          Center(
                            child: InkWell(
                                onTap: () =>
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (_) => LogIn())),
                                child: Text("هل لديك حساب بالفعل ؟",
                                  style: TextStyle(fontFamily: 'Cairo',
                                      decoration: TextDecoration.underline,
                                      fontSize: 18.sp),)),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
    );
  }
}