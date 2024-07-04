
import 'dart:convert';

import 'package:Reservation/core/network/api_url.dart';
import 'package:Reservation/core/network/my_http.dart';
import 'package:Reservation/features/list_of_category/data_layer/items_model.dart';
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
        var jsonResponse = ItemModel.fromJson(decodedData);

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





}
