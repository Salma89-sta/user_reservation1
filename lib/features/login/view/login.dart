import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Reservation/colors/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'login-form-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'loginWithGoogle.dart';

class LogIn extends StatefulWidget {
 
  @override
  State<LogIn> createState() => _LoginState();
}

class _LoginState extends State<LogIn> {
  var width, height, size ;
  final formKey = GlobalKey<FormState>();
  @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   PushNotificationsManager.init(context);
  // }
  @override
  Widget build(BuildContext context) {
    size= MediaQuery.of(context).size;
    height= size.height;
    width= size.width;
    return SafeArea(
      child: Scaffold(
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
                       loginWithGoogle(),
                        SignInButton(
                          Buttons.googleDark,
                          padding: EdgeInsets.all(10),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          text: "Sign in with Google",
                          onPressed: () {
                            _signInWithGoogle(context).then((value){
                              dynamic email = value?.currentUser?.email ;
                              value?.signOut() ;
                              if(email != null)
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithGoogle(email),));
                            });
                          },
                        ),
                        // TextButton(
                        //   onPressed: (){
                        //
                        //   },
                        //   child: Image.asset('assets/images/google.png', width: 70, height: 70,)
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<FirebaseAuth?> _signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;
        print("===================): ${user?.email}");
        if (user != null) {
          return _auth ;
        }
      }
    } catch (error) {
      print('Sign in with Google failed: $error');
      return null ;
    }
    return null ;
  }

}