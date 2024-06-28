import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/common/button.dart';
import 'package:Reservation/features/list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
import 'package:Reservation/features/list_of_category_details/view/slider_widget.dart';
import 'package:Reservation/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
import '../../../colors/app_colors.dart';
import '../../../common/list_of_data.dart';
import '../../categories/data_layer/model/categories_model.dart';
import '../../drawer/drawe_widget.dart';
import '../../list_of_category/business_layer/items_cubit.dart';
import '../../user_resservation_detailss/view/user_details_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../item_package_business_layer/item_package_cubit.dart';

class ListOfCategoryDetailsScreen extends StatefulWidget {
  final String name;
  final String description;

  final String address;
  // final String price;
  // final String priceIn;
  String categoryName;
  String itemId;
  String? itemDevices;

  List<Data>? checklistItems;
  String offer;

  ListOfCategoryDetailsScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.address,
    // required this.price,
    // required this.priceIn,
    required this.categoryName,
    required this.itemId,
    required this.itemDevices,
    required this.offer,
  }) : super(key: key);

  @override
  State<ListOfCategoryDetailsScreen> createState() =>
      _ListOfCategoryDetailsScreenState();
}

class _ListOfCategoryDetailsScreenState
    extends State<ListOfCategoryDetailsScreen> {
  List<String> selectedItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeListsFromData();
  }

  void saveSelectedData() {
    // Perform actions to save the selected data
    print('Selected Items: $selectedItems');
  }

  final List<String> _items = [];
  final List<String> _quantity = [];

  void initializeListsFromData() {
    String devicesData = widget.itemDevices ?? '[]';

    List<Map<String, dynamic>> decodedDevices = [];

    try {
      decodedDevices = List<Map<String, dynamic>>.from(
        jsonDecode(devicesData),
      );
    } catch (e) {
      print('Error decoding devices data: $e');
    }

    _items.clear();
    _quantity.clear();

    for (var device in decodedDevices) {
      String name = device['name'] ?? '';
      String number = device['number'] ?? '';

      // Check if both name and number are not empty before adding to the lists
      if (name.isNotEmpty && number.isNotEmpty) {
        _items.add(name);
        _quantity.add(number);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.itemId);
    print(
        "............................item id................................");
    var categoryItems = ItemsCubit.get(context);
    final addOp = AdditionalOptionsCubit.get(context);

    return BlocConsumer<AdditionalOptionsCubit, AdditionalOptionsState>(
      listener: (context, state) {
        if (state is AdditionalOptionsLoaded) {}
        // Return an empty container or show a loading indicator if needed
      },
      builder: (context, state) {
        return Scaffold(
          drawer: DrawerWidget(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: AppColors.litePurple,
            title: const Center(
                child: Text(
              "التفاصيل",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
            )),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //slider
                Container(
                  width: 100.w,
                  height: 30.h,
                  child: BlocProvider(
                    create: (context) => SliderCubit(),
                    child: SliderWidget(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.name}",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // height: 20.h,
                            child: Text(
                              "${widget.description}",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Cairo',
                                fontSize: 20.sp,
                              ),
                              textDirection: TextDirection.rtl,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Text(
                            " : الوصف",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      // Container(
                      //   alignment: AlignmentDirectional.centerEnd,
                      //   child: Text(  " : المواعيد",
                      //     style: TextStyle(
                      //         color: Colors.indigo,
                      //         fontFamily: 'Cairo',
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 20.sp),),
                      // ),
                      //
                      // BlocConsumer<ItemPackageCubit, ItemPackageState>(
                      //   listener: (context, state) {
                      //     // TODO: implement listener
                      //   },
                      //   builder: (context, state) {
                      //     var cubit = ItemPackageCubit.get(context);
                      //     return Container(
                      //       width: 90.w,
                      //       // height: 30.h,
                      //       child: ListView.builder(
                      //           shrinkWrap: true,
                      //           itemCount:
                      //               cubit.availabilityData.length,
                      //           itemBuilder: (context, index) {
                      //             return Directionality(
                      //               textDirection: TextDirection.rtl,
                      //               child: Row(
                      //                 children: [
                      //                   Text(" من: ", style:  TextStyle(
                      //                     color: Colors.indigo,
                      //                     fontFamily: 'Cairo',
                      //                     fontSize: 20.sp,
                      //                   ),),
                      //                   Text(cubit
                      //                       .availabilityData[index]
                      //                       .availableTimeFrom!, style:  TextStyle(
                      //                     color: Colors.indigo,
                      //                     fontFamily: 'Cairo',
                      //                     fontSize: 18.sp,
                      //                   ),),
                      //                   Text(" الي: ", style:  TextStyle(
                      //                     color: Colors.indigo,
                      //                     fontFamily: 'Cairo',
                      //                     fontSize: 20.sp,
                      //                   ),),
                      //                   Text(cubit
                      //                       .availabilityData[index]
                      //                       .availableTimeTo!, style:  TextStyle(
                      //                     color: Colors.indigo,
                      //                     fontFamily: 'Cairo',
                      //                     fontSize: 18.sp,
                      //                   ),),
                      //                   Text(" السعر: ", style:  TextStyle(
                      //                     color: Colors.indigo,
                      //                     fontFamily: 'Cairo',
                      //                     fontSize: 20.sp,
                      //                   ),),
                      //                   Text(cubit
                      //                       .availabilityData[index]
                      //                       .price!, style:  TextStyle(
                      //                     color: Colors.indigo,
                      //                     fontFamily: 'Cairo',
                      //                     fontSize: 18.sp,
                      //                   ),),
                      //                 ],
                      //               ),
                      //             );
                      //           }),
                      //     );
                      //   },
                      // ),
                      //
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            ": المقتنيات  ",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            // height: 15.h,
                            child: ListOfData(
                              checklistItems: _items,
                              checklistcount: _quantity,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            ": الاضافات ",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: addOp.options.length,
                            itemBuilder: (context, index) {
                              final option = addOp.options[index];
                              final itemName = option.name.toString();
                              final itemPrice = option.price.toString();

                              return CheckboxListTile(
                                title: Text(
                                  '$itemName , السعر  : $itemPrice ',
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                value: selectedItems.contains(itemName),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedItems.add(itemName);
                                    } else {
                                      selectedItems.remove(itemName);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Button0(
                    widget: Center(
                        child: Text(
                      "للحجز",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: 'Cairo',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    )),
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                          create: (context) =>
                                              AdditionalOptionsCubit()
                                                ..getAdditionalOptions(
                                                    widget.itemId)),
                                      BlocProvider(
                                          create: (context) =>
                                          ItemPackageCubit()
                                            ..getIemPackage(
                                                widget.itemId),
                                      )
                                    ],
                                    child: BlocProvider(
                                      create: (context) =>
                                          AddReservationCubit(),
                                      child: AddReservationScreen(
                                        categoryName: widget.categoryName,
                                        itemId: widget.itemId,
                                        // price: widget.price,
                                        // pricePer: widget.priceIn,
                                        offer: widget.offer,
                                      ),
                                    ),
                                  )));
                    }),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
