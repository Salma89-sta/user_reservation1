import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rservation_user/features/home/data_layer/get_user_reservations.dart';

import '../../../core/network/api_url.dart';
import '../../../core/network/my_http.dart';

part 'user_update_data_state.dart';

class UserUpdateDataCubit extends Cubit<UserUpdateDataState> {
  UserUpdateDataCubit() : super(UserUpdateDataInitial());

  static UserUpdateDataCubit get(context) => BlocProvider.of(context);
  UserReservationsModel? userReservationsModel;

  updateData(String name, String email, String id, String nid, String password) async {



    var response = await MyHttp.post(endPoint: API.userUpdateData, data: {
      'name': name,
      'id':id,
      'email':email,
      'nid':nid,
      'password':password,
    });


    if(response.statusCode == 200){
      print(response.statusCode);

      var jsonResponse = UserReservationsModel.fromJson(jsonDecode(response.body.toString()));

      if(jsonResponse.success.toString() =='true'){
        print(jsonResponse.success.toString());
        emit(UserUpdateDataSuccess());
      }


    }else{
      emit(UserUpdateDataFailed());
    }

  }


}
