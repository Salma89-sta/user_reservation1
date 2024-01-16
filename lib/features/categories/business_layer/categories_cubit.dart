import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rservation_user/core/network/api_url.dart';
import '../../../core/network/my_http.dart';
import '../data_layer/model/categories_model.dart';
part  'categories_state.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  List<Data> categories = [];

  getCategories() async {
    emit(GetCategoriesLoading());
    try {
      var response = await MyDio.get(endPoint: API.getCategories);
      print("-----------------  getCategories  -----------------");
      print(response!.statusCode);
      if (response!.statusCode == 200) {
        print(response.data);
        var decodedData = json.decode(response.data);
        print(decodedData);
        var jsonResponse =await CategoriesModel.fromJson(decodedData);

        if (jsonResponse.success!) {
          print("categories");
          categories = jsonResponse.data!;
          print(categories);
          if(categories.toString() != null){
            print("...................00000........");
            emit(GetCategoriesSuccess());
          }
        } else {
          print(response.data);
          print(response.statusCode);
          emit(GetCategoriesFailure());
        }
      } else {
        print(response.data);
        print(response.statusCode);
        emit(GetCategoriesFailure());
      }
    } catch (e) {
      print(e);
      emit(GetCategoriesFailure());
    }
  }
}

// import 'dart:convert';
//
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rservation_user/core/network/api_url.dart';
// import 'package:rservation_user/core/network/my_http.dart';
// import 'package:rservation_user/features/categories/data_layer/model/categories_model.dart';
//
// part  'categories_state.dart';
//
//
//
// class CategoryCubit extends Cubit<CategoryState> {
//
//   CategoryCubit() : super(CategoryInitial());
//
//   static CategoriesModel get(context) => BlocProvider.of(context);
//
//   List<Data> categories = [];
//
//   getCategories() async{
//
//     emit(GetCategoriesLoading());
//
//     try{
//       var response = await MyDio.get(endPoint: API.getCategories);
//
//       if (response?.statusCode==200){
//         print("userReservations");
//         print(response!.data);
//
//         var decodedData = json.decode(response.data);
//         var jsonResponse =await CategoriesModel.fromJson(decodedData);
//
//         if(jsonResponse.success.toString() =="true"){
//           if(jsonResponse.data.toString() != null){
//             categories = jsonResponse.data!;
//             print(categories);
//             emit(GetCategoriesSuccess());
//           }
//
//         }else{
//           emit(GetCategoriesFailure());
//         }
//
//       }else{
//         emit(GetCategoriesFailure());
//       }
//     }catch(e){
//       emit(GetCategoriesFailure());
//     }
//
//   }
//
// }
