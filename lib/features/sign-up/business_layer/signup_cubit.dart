import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rservation_user/core/network/my_http.dart';
import 'package:rservation_user/features/sign-up/data_layer/signup_model.dart';

import '../../../core/network/api_url.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState>{
  SignupCubit() : super(SignypInitial());

  SignupModel? signupModel;

  static SignupCubit get(context) => BlocProvider.of(context);

  void userSignup( String name, String email, String phone, String  passWord, String nid) async{

    emit(SignupLoading());

    try{
      Map<String, dynamic> modelData= {
        "email":email,
        "password":passWord,
        "name":name,
        "phone":phone,
        "nid":nid,
      };

      var response = await MyHttp.post(endPoint: API.signup, data: modelData);


      if(response!.statusCode ==200 ){
        var jsonResponse = SignupModel.fromJson(jsonDecode(response.body));

        print("...........${jsonResponse.success}.................");
        if(jsonResponse.success.toString() == "true"){
          print("success");
          emit(SignupSuccess());
        }else{
          print("success but user already exist");

          emit(SignupDublicate());
        }

      }else{
        print(response.statusCode);
      }
    }catch (e) {
      print("..............${e.toString()}");
      emit(SignupError(e.toString()));
      print(e.toString());
    }

  }
}