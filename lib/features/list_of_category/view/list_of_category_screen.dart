import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rservation_user/features/drawer/drawe_widget.dart';
import 'package:rservation_user/features/list_of_category/business_layer/items_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/features/list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
import 'package:rservation_user/features/list_of_category_details/view/slider_widget.dart';
import '../../list_of_category_details/view/List_of_category_details_screen.dart';
import 'card_of_category_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListOfCategoryScreen extends StatefulWidget {
  const ListOfCategoryScreen({Key? key}) : super(key: key);
  @override
  State<ListOfCategoryScreen> createState() => _ListOfCategoryScreenState();

}

class _ListOfCategoryScreenState extends State<ListOfCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    print("................................................");
    var categoryItems = ItemsCubit.get(context);

    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Center(child: Text("العناصر", style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold),)),
      ),
      body: BlocConsumer<ItemsCubit, ItemsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return (state is ItemsLoading)? Center(child: CircularProgressIndicator()):
          (state is ItemsLoaded)?(categoryItems.categoryItems.isNotEmpty)?
          Container(
            width: 100.w,
            height: 90.h,
            // color: Colors.red,
              child: ListView.builder(

                // physics: NeverScrollableScrollPhysics(),
                  itemCount:categoryItems.categoryItems.length,
                  itemBuilder: (context, index){

                    return ListOfCategory(calenderWidget: categoryItems.categoryItems[index].availableTimeFrom!,
                      // listOfCategoryImage: categoryItems.categoryItems[index].logo!,
                      listOfCategoryImage:  CachedNetworkImage(
                        imageUrl:
                        categoryItems.categoryItems[index].logo!,
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              width: 100.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.sp),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,

                                ),
                              ),
                            ),
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ) ,
                      listOfCategoryName: categoryItems.categoryItems[index].name!,
                      listOfCategoryDescription: categoryItems.categoryItems[index].description!,
                      listOfCategoryPricePerDay: categoryItems.categoryItems[index].price!,
                      listOfCategoryStatus: (categoryItems.categoryItems[index].status! == '0')?"في الصيانه ": "متاح",
                      forMoreDetails: () {
                      imagesFromAPI =[
                        categoryItems.categoryItems[index].image1.toString(),
                        categoryItems.categoryItems[index].image2.toString(),
                        categoryItems.categoryItems[index].image3.toString(),
                        ];

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(
providers: [
  BlocProvider( create: (context) => ItemsCubit(), ),
                        BlocProvider( create: (context) =>
                        AdditionalOptionsCubit()..getAdditionalOptions(categoryItems.categoryItems[index].id!),
)],
  child: ListOfCategoryDetailsScreen(
                                            name: categoryItems.categoryItems[index].name!,
                                            description: categoryItems.categoryItems[index].description!,
                                            address:  categoryItems.categoryItems[index].address!,
                                            price:  categoryItems.categoryItems[index].price!,
                                            priceIn:  categoryItems.categoryItems[index].type!,
                                            categoryName: categoryItems.categoryItems[index].categoryName!,
                                            itemId: categoryItems.categoryItems[index].id!,
                                            itemDevices: categoryItems.categoryItems[index].devices!
                      ),
) )
                      );
                      },
                      priceIn: categoryItems.categoryItems[index].type!,
                      offer:  categoryItems.categoryItems[index].offer!, itemId:  categoryItems.categoryItems[index].id!,);
                  },

              ),
          ):Container(child: Center(child:Text("لا يوجد عناصر "),),):(state is NoItems)? Container(
            child: Center(
              child: Text("لا يوجد عناصر"),
            ),
          ):Container(
            child: Text("لا يوجد اتصال بالانترنت "),
          );
        },
      ),
    );
  }
}