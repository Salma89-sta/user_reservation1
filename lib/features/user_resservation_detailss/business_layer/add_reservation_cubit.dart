import 'dart:convert';
import 'package:Reservation/features/user_resservation_detailss/data_layer/add_reservation_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Reservation/core/network/my_http.dart';
import '../../../core/network/api_url.dart';
import '../data_layer/update_reservation_model.dart';

part 'add_reservation_state.dart';

class AddReservationCubit extends Cubit<AddReservationState> {
  AddReservationCubit() : super(AddReservationInitial());
  static AddReservationCubit get(context) => BlocProvider.of(context);

  addReservation (
      {required String userId,
      required String categoryName,
      required String itemId,
      required String time,
        required String from,
        required String to,
      String? approveOfPayment,
      String? doc,
       required String price,
      String? paid,
      String? additionalOp,
      required String maritalStatus,
        String? offer,
        String? comment,
        required String packageId

      })
  async {
    try{
      emit(AddReservationLoading());
      var response = await MyHttp.post(endPoint: API.addReservation, data: {
        'user_id':userId,
        'category_name':categoryName,
        'item_id':itemId,
        'package_id':packageId,
        'time':time.toString(),
        'time_of_reservation_from':from.toString(),
        'time_of_reservation_to':to.toString(),
        'approve_of_payment':approveOfPayment,
        'document':doc,
        'price':price,
        'paid':paid,
        'additional_options':additionalOp,
        'marital_status': maritalStatus,
        'offer' :offer,
        'comment': comment,
      }
      );


      print(".................reservation..........");
      print(from.toString());
      print(to.toString());

      if(response.statusCode ==200){

        print("add reservation ${response.statusCode}");
        print("add reservation ${response.body}");

        var jsonResponse = AddReservationModel.fromJson(jsonDecode(response.body.toString()));
        if(jsonResponse.success.toString() =='true'){

          emit(AddReservationSuccessfully());
        }else{
          emit(AddReservationAlreadyReserved());
          print(jsonResponse.success);

        }
      }else{
        print("..........................");

        print(response.statusCode);

        emit(AddReservationFailed());
      }

    }catch (e){
      print("catch error");
      print(e.toString());
    }
  }

  updateReservation (
      { required String reservationId,
        required String userId,
        required String categoryName,
        required String itemId,
        required String time,
        required String from,
        required String to,
        String? approveOfPayment,
        String? doc,
        required String price,
        String? paid,
        String? additionalOp,
        required String maritalStatus,
      required String package_id,
      })
  async {
    try{
      emit(UpdateReservationLoading());
      var response = await MyHttp.post(endPoint: API.updateReservation, data: {
        'id':reservationId,
        'user_id':userId,
        'category_name':categoryName,
        'item_id':itemId,
        'time':time.toString(),
        'time_of_reservation_from':from.toString(),
        'time_of_reservation_to':to.toString(),
        'approve_of_payment':approveOfPayment,
        'document':doc,
        'price':price,
        'paid':paid,
        'additional_options':additionalOp,
        'marital_status': maritalStatus,
        'package_id':package_id,

      }
      );

      if(response.statusCode ==200){

        print("edit reservation ${response.statusCode}");

        var jsonResponse = UpdateReservationModel.fromJson(jsonDecode(response.body.toString()));


        print("................................");
        print(jsonResponse.success.toString());

        if(jsonResponse.success.toString() =='true'){

          print("reservation updated successfully");

          emit(UpdateReservationSuccessfully());
        }else{
          print("reservation fail ");

          print(response.body);
          emit(UpdateReservationFailed());

        }
      }else{
        print("reservation fail successfully");

        print(response.body);

        emit(UpdateReservationFailed());
      }

    }catch (e){
      emit(UpdateReservationFailed());

      print("catch error");
      print(e.toString());
    }
  }

}
