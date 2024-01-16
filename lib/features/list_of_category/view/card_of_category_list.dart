import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rservation_user/features/list_of_category/business_layer/items_cubit.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../colors/app_colors.dart';

class ListOfCategory extends StatefulWidget {

  final Widget listOfCategoryImage;
  final String listOfCategoryName;
  final String priceIn;
  final String calenderWidget;
  final String listOfCategoryDescription;
  final String listOfCategoryPricePerDay;
  final VoidCallback forMoreDetails;
  final String offer;
  final String itemId;


  final String listOfCategoryStatus;


  const ListOfCategory({Key? key,required this.calenderWidget,required this.listOfCategoryImage, required this.listOfCategoryName, required this.listOfCategoryDescription, required this.listOfCategoryPricePerDay, required this.listOfCategoryStatus, required this.forMoreDetails, required this.priceIn, required this.offer, required this.itemId}) : super(key: key);

  @override
  State<ListOfCategory> createState() => _ListOfCategoryState();
}

class _ListOfCategoryState extends State<ListOfCategory> {
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
    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    child:widget.listOfCategoryImage ,


    ),
      SizedBox(height: 5,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 10,),
          // calenderWidget,
          SizedBox(width: 10,),
          Text("${widget.listOfCategoryName}", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),
        ],
      ),
      // SizedBox(height: 5,),
      // Padding(
      //   padding: const EdgeInsets.only(right: 10.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end ,
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       SizedBox(width: 10,),
      //       Text("${widget.listOfCategoryDescription}", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',fontSize: 18.sp),),
      //       Text(" : الوصف", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),
      //     ],
      //   ),
      // ),

      SizedBox(height: 5,),
      Row(
        mainAxisAlignment: MainAxisAlignment.end ,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 10,),
          Text("${widget.listOfCategoryPricePerDay}", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',  fontSize: 18.sp),),
          Text(" : ${widget.priceIn} ",style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),
          Text(" السعر ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),

        ],
      ),
      SizedBox(height:10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end ,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 10.w,),
          Text("${widget.listOfCategoryStatus}",style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',  fontSize: 18.sp),),
          Text(" : الحاله  ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),

        ],
      ),
      SizedBox(height:10),

      Row(
        mainAxisAlignment: MainAxisAlignment.end ,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text((widget.offer.trim() == '')? "لايوجد" : widget.offer,style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',  fontSize: 18.sp),),
          Text(" : عرض  ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18.sp),),
        ],
      ),


      Row(
        mainAxisAlignment: MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<ItemsCubit, ItemsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = ItemsCubit.get(context);
    return IconButton(
        onPressed: (){
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  padding: EdgeInsets.all(16),
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
                            cubit.getItemFreeTimes(date.toString(), widget.itemId);
                            _selectedDate = date;

                          showDialog(context: context,   builder: (BuildContext context) {
                            return AlertDialog(
                              content:SizedBox(
                                height:
                                480,
                                width:
                                200,
                                child: ListView
                                    .builder(
                                  itemCount: cubit
                                      .freeTimes!
                                      .length,
                                  itemBuilder:
                                      (context, index) {
                                    if (index <
                                        cubit.freeTimes!.length) {
                                      print(cubit.freeTimes![index].toString());
                                      return ListTile(
                                        title: Text(" متاح الساعه  :" + cubit.freeTimes![index].toString()),
                                        // ... other code
                                      );
                                    } else {
                                      // Handle the case when the index is out of bounds
                                      return SizedBox.shrink(); // or another widget
                                    }
                                  },
                                ),
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
            
          }, icon: Icon(Icons.calendar_today_rounded));
  },
),
          InkWell(
            onTap: widget.forMoreDetails,
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
