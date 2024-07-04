import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Reservation/core/network/my_http.dart';
import 'package:Reservation/features/list_of_category_details/data_layer/additional_options_model.dart';
import '../../../core/network/api_url.dart';
part 'additional_options_state.dart';

class AdditionalOptionsCubit extends Cubit<AdditionalOptionsState> {
  AdditionalOptionsCubit() : super(AdditionalOptionsInitial());

  static AdditionalOptionsCubit get(context) => BlocProvider.of(context);

  List<Data> options =[];
  getAdditionalOptions (String itemId) async {
    print(itemId);

  try{
    var response = await MyHttp.post(endPoint: API.itemOptions, data: {
      'item_id': itemId,
    });

    if(response.statusCode ==200){
      print(response.statusCode);

      var jsonResponse = AdditionalOptionsModel.fromJson(jsonDecode(response.body));

      print(jsonResponse.success.toString() );
      print(jsonResponse.data );

      if (jsonResponse.success.toString() == 'true'){
        emit(AdditionalOptionsLoaded());
        print(jsonResponse.data!);
       options = jsonResponse.data!;
       print("...................${options[0].name}.......................");
       print(options.toList().toString());
      }emit(AdditionalOptionsFailed());
    }else{
      emit(AdditionalOptionsFailed());
    }
  }catch(e){
    print(e.toString());
    emit(AdditionalOptionsFailed());
  }

  }

}
