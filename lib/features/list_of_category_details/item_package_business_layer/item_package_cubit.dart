import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Reservation/core/network/api_url.dart';
import 'package:Reservation/core/network/my_http.dart';
import 'package:Reservation/features/list_of_category_details/data_layer/item_package_model.dart';

part 'item_package_state.dart';

class ItemPackageCubit extends Cubit<ItemPackageState> {
  ItemPackageCubit() : super(ItemPackageInitial());

  static ItemPackageCubit get(context) => BlocProvider.of(context);
  List<Data> availabilityData=[];
  Future<void> getIemPackage(String itemId) async{
    emit(ItemPackageLoading());
    try{
      var response = await MyHttp.post(endPoint: API.itemPackage, data: {
        'item_id': itemId,
      });
      print(itemId);

      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = itemPackage.fromJson(jsonDecode(response.body));
        availabilityData = jsonResponse.data!;
        print(availabilityData);
        emit(ItemPackageLoaded());
      } else {
        emit(ItemPackageFailed());
      }

    }catch(e){
      emit(ItemPackageFailed());
      print(e.toString());
    }
  }


}
