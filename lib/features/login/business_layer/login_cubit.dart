import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rservation_user/core/network/api_url.dart';
import 'package:rservation_user/features/login/data_layer/model/login_model.dart';
import 'package:equatable/equatable.dart';
import '../../../core/cache_helper/cache_helper.dart';
import '../../../core/network/my_http.dart';

part 'login_state.dart';

class AuthCubit extends Cubit<LoginState> {

  AuthCubit() : super(LoginInitial());


  static AuthCubit get(context) => BlocProvider.of(context);
  bool ispasswordshow = true;
  IconData suffixicon = Icons.visibility_off;

  void showLoginpassword() {
    ispasswordshow = !ispasswordshow;
    suffixicon = ispasswordshow ? Icons.visibility : Icons.visibility_off;
    // emit(PasswordIconChangestate());
  }

  loginModel? userModel;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    // showLoading();
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };
    try {
      var response = await MyHttp.post(endPoint: API.login, data: data);



      print(response.body.toString());
      if (response!.statusCode == 200) {

        var jsonResponse = loginModel.fromJson(jsonDecode(response.body.toString()));

        print(jsonResponse.userData.toString());

        if (jsonResponse.success.toString() =="true") {
          if (jsonResponse.userData!.type.toString() == "B2" ) {
            if(jsonResponse.userData!.status == "1" ){
              await CacheHelper.init();
              CacheHelper.saveData(key: "name", value: jsonResponse.userData!.name.toString());
              CacheHelper.saveData(key: "email", value: jsonResponse.userData!.email.toString());
              CacheHelper.saveData(key: "nid", value: jsonResponse.userData!.nid.toString());
              CacheHelper.saveData(key: "password", value: jsonResponse.userData!.password.toString());
              CacheHelper.saveData(key: "id", value: jsonResponse.userData!.id.toString());

              CacheHelper.saveData(key: "phoneNumber", value: jsonResponse.userData!.phone.toString());
              userModel = jsonResponse;
              // hideLoading();
              emit(LoginSuccess());
            }else{
              emit(LoginNotAcceptedYet());
            }
          } else {
            Fluttertoast.showToast(msg: "المستخدم غير موجود",textColor: Colors.white, backgroundColor: Colors.deepOrange);

            emit(LoginError("المستخدم غير موجود"));
          }
        } else {
          Fluttertoast.showToast(msg: "حدث خطا اثناء تسجيل البيانات",textColor: Colors.white, backgroundColor: Colors.deepOrange);

          emit(LoginError("حدث خطا اثناء تسجيل البيانات "));
        }
      } else {
        Fluttertoast.showToast(msg: "حدث خطا ",textColor: Colors.white, backgroundColor: Colors.deepOrange);

        emit(LoginError("حدث خطأ"));
      }
    } catch (e) {
      print(e.toString());
      emit(LoginError("حدث خطأ"));
    }
  }
}