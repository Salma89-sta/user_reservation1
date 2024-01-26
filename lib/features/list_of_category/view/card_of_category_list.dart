import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/features/list_of_category/business_layer_free_times/free_times_cubit.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListOfCategory extends StatelessWidget {

  final Widget listOfCategoryImage;
  final String listOfCategoryName;
  final String priceIn;
  // final String calenderWidget;
  final String listOfCategoryDescription;
  final String listOfCategoryPricePerDay;
  final VoidCallback forMoreDetails;
  final String offer;
  final String itemId;


  final String listOfCategoryStatus;


   ListOfCategory({Key? key,required this.listOfCategoryImage, required this.listOfCategoryName, required this.listOfCategoryDescription, required this.listOfCategoryPricePerDay, required this.listOfCategoryStatus, required this.forMoreDetails, required this.priceIn, required this.offer, required this.itemId}) : super(key: key);

  Widget? calenderWidget;

  @override
  Widget build(BuildContext context) {
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _selectedDate = DateTime.now();
    return Padding(
    padding: const EdgeInsets.only(top:20.0),
    child: Center(
    child: Container(
    width: 75.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border:Border.all(
    color: Colors.deepOrange,
    width:2,

    ),
    ),

    child: Column(
    children: [
    ClipRRect(
    borderRadius:const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    child:listOfCategoryImage ,

    ),
      const SizedBox(height: 5,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10,),
          // calenderWidget,
          const SizedBox(width: 10,),
          Text("$listOfCategoryName", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),
        ],
      ),

      SizedBox(height: 5,),
      Row(
        mainAxisAlignment: MainAxisAlignment.end ,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 10,),
          Text("$listOfCategoryPricePerDay", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',  fontSize: 18.sp),),
          Text(" : $priceIn ",style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),
          Text(" السعر ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),

        ],
      ),
      SizedBox(height:10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end ,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 10.w,),
          Text("$listOfCategoryStatus",style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',  fontSize: 18.sp),),
          Text(" : الحاله  ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),

        ],
      ),
      SizedBox(height:10),

      Row(
        mainAxisAlignment: MainAxisAlignment.end ,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text((offer.trim() == '')? "لايوجد" : offer,style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',  fontSize: 18.sp),),
          Text(" : عرض  ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),
        ],
      ),


      Row(
        mainAxisAlignment: MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<FreeTimesCubit, FreeTimesState>(
  listener: (context, state) {
    if(state is ItemFreeTimesLoading){
      calenderWidget = CircularProgressIndicator();
    }else if(state is ItemFreeTimesLoaded){
    }
  },
  builder: (context, state) {
    var cubit = FreeTimesCubit.get(context);
    return IconButton(
        onPressed: (){
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  padding:const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TableCalendar(
                        calendarFormat: _calendarFormat,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        focusedDay: _selectedDate,
                        firstDay: DateTime(DateTime.now().year - 1),
                        lastDay: DateTime(DateTime.now().year + 1),
                        selectedDayPredicate: (date) {
                          return isSameDay(_selectedDate, date);
                        },
                        onDaySelected: (date, events) {
                          print("on day selected ${date.toString()}");
                          String formattedTime = DateFormat('yyy-MM-dd').format(date);
                            cubit.getItemFreeTimes(formattedTime, itemId);
                            _selectedDate = date;

                          showDialog(context: context,   builder: (BuildContext context) {
                            return AlertDialog(
                              content:Column(
                                children: [
                                  Text("المواعيد المتاحه", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Container(width: 180, height: 3, color: Colors.grey,),
                                  SizedBox(
                                    width:
                                    200,
                                    height: 100,
                                    child: ListView.builder(
                                      shrinkWrap: false,
                                      itemCount: cubit.freeTimes!.length,
                                      itemBuilder:
                                          (context, index) {
                                        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                        print(cubit.freeTimes!);
                                        print(cubit.freeTimes!.length);
                                          if(state is ItemFreeTimesLoaded){
                                            if (index < cubit.freeTimes!.length) {
                                              return ListTile(
                                                title: Text(" متاح من  :" + cubit.freeTimes![index].toString()),
                                                // ... other code
                                              );}else{
                                              return ListTile(
                                                title: Text("لا يوجد مواعيد متاحه"),
                                                // ... other code
                                              );
                                            }
                                          }else if (state is ItemFreeTimesLoading){
                                            return CircularProgressIndicator();
                                          }else{
                                            return ListTile(
                                              title: Text("لا يوجد مواعيد متاحه"),
                                              // ... other code
                                            );
                                          }
                                          }
                                          ),
                                  ),
                                ],
                              ),

                            );});

                        },
                        calendarStyle:const CalendarStyle(
                          // weekendTextStyle: TextStyle(color: Colors.red),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          // markersColor: Colors.green,
                        ),
                        headerStyle:const HeaderStyle(
                          formatButtonVisible: true,
                          titleCentered: true,
                          titleTextStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          }, icon: Icon(Icons.calendar_today_rounded ,color: Colors.black, ));
  },
),
          InkWell(
            onTap: forMoreDetails,
            child: Text("لمزيد من التفاصيل", style: TextStyle(color: Colors.black,decoration: TextDecoration.underline, fontFamily: 'Cairo',
            ),),
          ),
        ],
      ),

    ],
      ),

      ),
      ),
      );
  }
}
