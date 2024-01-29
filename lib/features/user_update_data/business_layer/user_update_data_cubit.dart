import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Reservation/features/home/data_layer/get_user_reservations.dart';

import '../../../core/network/api_url.dart';
import '../../../core/network/my_http.dart';

part 'user_update_data_state.dart';

class UserUpdateDataCubit extends Cubit<UserUpdateDataState> {
  UserUpdateDataCubit() : super(UserUpdateDataInitial());

  static UserUpdateDataCubit get(context) => BlocProvider.of(context);
  UserReservationsModel? userReservationsModel;

  updateData(
      {required String name,
        required String email,
        required String id,
        required String nid,
        required String password}) async {



    var response = await MyHttp.post(endPoint: API.userUpdateData, data: {
      'name': name,
      'id':id,
      'email':email,
      'nid':nid,
      'password':password,
    });

    print(email);
    print(password);
    print(nid);
    print(name);



    if(response.statusCode == 200){
      print(response.statusCode);

      var jsonResponse = UserReservationsModel.fromJson(jsonDecode(response.body.toString()));

      if(jsonResponse.success.toString() =='true'){
        print("data updated success...");
        print(jsonResponse.success.toString());
        emit(UserUpdateDataSuccess());
      }


    }else{
      print("data updated failed...");
      emit(UserUpdateDataFailed());
    }

  }


}
