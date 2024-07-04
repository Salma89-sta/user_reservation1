
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_url.dart';
import '../../../core/network/my_http.dart';
import '../data_layer/calender_model.dart';

part 'free_times_state.dart';

class FreeTimesCubit extends Cubit<FreeTimesState> {
  FreeTimesCubit() : super(FreeTimesInitial());

  static FreeTimesCubit get(context) => BlocProvider.of(context);

  List<dynamic> freeTimes = [];
  getItemFreeTimes(String date, String itemId) async{
    emit(ItemFreeTimesLoading());

    try{
      var response = await MyHttp.post(endPoint: API.calenderData, data: {
        'day': date,
        'item_id' : itemId,
      });
      print(date);
      print(itemId);

      if(response.statusCode == 200){
        print(response.body);
        var responseDecode = CalenderModel.fromJson(jsonDecode(response.body));

        print(responseDecode.success.toString());

        if(responseDecode.success.toString() == 'true'){

          freeTimes= responseDecode.availableTime!;
          print(".........................free times....................................");
          print(freeTimes);
          emit(ItemFreeTimesLoaded());

        }
        else if(responseDecode.success.toString() == 'false'){
          freeTimes=[];
          emit(ItemFreeTimesFailed());
        }
        print(freeTimes.length);
      }else {
        emit(ItemFreeTimesFailed());
      }
    }catch (e){
      emit(ItemFreeTimesFailed());
      print(e.toString());
    }
  }

}
