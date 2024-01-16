import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rservation_user/core/cache_helper/cache_helper.dart';
import 'package:rservation_user/core/network/api_url.dart';
import 'package:rservation_user/core/network/my_http.dart';
import 'package:rservation_user/features/home/data_layer/delete_reservation_model.dart';

import '../data_layer/get_user_reservations.dart';

part 'user_reservations_state.dart';

class UserReservationsCubit extends Cubit<UserReservationsState> {
  UserReservationsCubit() : super(UserReservationsInitial());

  static UserReservationsCubit get(context) => BlocProvider.of(context);

  List<Data> userReservationsData = [];

  Future<void> getUserReservations(String id) async{
    emit(UserReservationsLoading());

  try{
    var response = await MyHttp.post(endPoint: API.getUserReservations, data: {"user_id": CacheHelper.getData(key: 'id')});

    print(id);
    if (response?.statusCode==200){
      print("userReservations");
      print(response!.body.toString());

      var jsonResponse = UserReservationsModel.fromJson(jsonDecode(response.body));

      print(jsonResponse.success);

      if(jsonResponse.success.toString() =="true"){

        userReservationsData = jsonResponse.data!;
        print(userReservationsData);
        emit(UserReservationsLoaded());

      }else{
        emit(UserReservationsFailed());
      }

    }else{
      emit(UserReservationsFailed());
    }
  }catch(e){
    emit(UserReservationsFailed());
    }

  }

  userDeleteReservation(String reservationId) async {
    try{
      var response = await MyHttp.post(endPoint: API.deleteReservation, data: {
        "id":reservationId,
      });

      if(response.statusCode ==200){

        var jsonResponse = DeleteReservationModel.fromJson(jsonDecode(response.body));

        if(jsonResponse.success.toString() == 'true' ){
          print("reservation deleted suc");
          emit(UserDeleteReservationSuccess());
        }

      }else{
        emit(UserDeleteReservationFail());
      }

    }catch(e){
      emit(UserDeleteReservationFail());
    }
  }

}
