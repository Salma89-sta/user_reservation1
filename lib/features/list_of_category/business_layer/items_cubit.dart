
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:rservation_user/core/network/api_url.dart';
import 'package:rservation_user/core/network/my_http.dart';
import 'package:rservation_user/features/list_of_category/data_layer/calender_model.dart';
import 'package:rservation_user/features/list_of_category/data_layer/items_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit() : super(ItemsInitial());

  static ItemsCubit get(context) => BlocProvider.of(context);
  List<Data> categoryItems =[];

  getCategoryItems(String categoryName) async {

    emit(ItemsLoading());
    try{
      print(categoryName);
      var response = await MyDio.post(endPoint: API.getCategoryItem, data:  {"category_name" : categoryName});

      if(response?.statusCode == 200){
        var decodedData = json.decode(response?.data);
        var jsonResponse = ItemsModel.fromJson(decodedData);

        if(jsonResponse.success.toString() == "true"){
          if(jsonResponse.data != null){
            categoryItems = jsonResponse.data!;
            print("............................................................");
            print("categoryItems");
            print(categoryItems);
            emit(ItemsLoaded());


          }else{
            print(response?.statusCode);
            print("............................no................................");

            emit(NoItems());

          }
        }


      }
    }catch (e){
      print("...................error");
      print(e.toString());
      emit(ItemsFail());

    }
  }

  List<int> freeTimes=[];
  getItemFreeTimes(String date, String itemId) async{
    try{

      emit(ItemFreeTimesLoading());
      var response = await MyHttp.post(endPoint: API.calenderData, data: {
        'date': date,
        'item_id' : itemId,
      });

      if(response.statusCode == 200){

        var responseDecode = CalenderModel.fromJson(jsonDecode(response.body));

        if(responseDecode.success.toString() == 'true'){

          freeTimes= responseDecode.availableTime!;
          print(freeTimes);
          emit(ItemsLoaded());

        }
      }else{
        emit(ItemFreeTimesFailed());
      }
    }catch (e){
      print(e.toString());
    }
  }



}
