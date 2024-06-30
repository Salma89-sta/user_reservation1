import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/features/list_of_category/business_layer_free_times/free_times_cubit.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../colors/app_colors.dart';

class ListOfCategory extends StatelessWidget {
  final Widget listOfCategoryImage;
  final String listOfCategoryName;

  // final String priceIn;
  // final String calenderWidget;
  final String listOfCategoryDescription;
  final String listOfCategoryPricePerDay;
  final VoidCallback forMoreDetails;
  final String offer;
  final String itemId;

  final String listOfCategoryStatus;

  ListOfCategory(
      {Key? key,
      required this.listOfCategoryImage,
      required this.listOfCategoryName,
      required this.listOfCategoryDescription,
      required this.listOfCategoryPricePerDay,
      required this.listOfCategoryStatus,
      required this.forMoreDetails,
      required this.offer,
      required this.itemId})
      : super(key: key);

  Widget? calenderWidget;

  @override
  Widget build(BuildContext context) {
    var cubit = FreeTimesCubit.get(context);

    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _selectedDate = DateTime.now();
    return BlocConsumer<FreeTimesCubit, FreeTimesState>(
      listener: (context, state) {
        if (state is ItemFreeTimesLoading) {
          EasyLoading.show();
        } else if (state is ItemFreeTimesLoaded) {
          EasyLoading.dismiss();

          // Future.delayed(const Duration(seconds: 2), () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    height: 60.h,
                    child: Column(
                      children: [
                        Text(
                          "المواعيد المتاحه",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 180,
                          height: 3,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50.h,
                          child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: cubit.freeTimes.length,
                              itemBuilder: (context, index) {
                                if (state is ItemFreeTimesLoaded) {
                                  if (index < cubit.freeTimes.length) {
                                    return ListTile(
                                      title: Text(" متاح من  :" +
                                          cubit.freeTimes![index].toString()),
                                      // ... other code
                                    );
                                  } else {
                                    return ListTile(
                                      title: Text("لا يوجد مواعيد متاحه",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold)),
                                      // ... other code
                                    );
                                  }
                                } else if (state is ItemFreeTimesLoading) {
                                  return CircularProgressIndicator();
                                } else {
                                  return ListTile(
                                    title: Text("لا يوجد مواعيد متاحه",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold)),
                                    // ... other code
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),

                  // );}
                );
              });
        } else {
          EasyLoading.dismiss();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    height: 30.h,
                    child: Column(
                      children: [
                        Container(
                            width: 100.w,
                            height: 10.h,
                            decoration: const BoxDecoration(
                                color: AppColors.litePurple),
                            child: Center(
                                child: Text(
                              "المواعيد المتاحه",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18.sp),
                            ))),
                        // Container(width: 180, height: 3, color: Colors.grey,),
                        SizedBox(
                          width: 200,
                          height: 20.h,
                          child: Center(
                              child: Text(
                            "لايوجد مواعيد متاحه",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      },
      builder: (context, state) {
        return Container(
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            border: Border.all(
              color: AppColors.litePurple,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:  BorderRadius.only(
                    topRight: Radius.circular(20.sp),
                    topLeft: Radius.circular(20.sp)),
                child: listOfCategoryImage,

              ),
              const SizedBox(
                height: 5,
              ),

              Text(
                "$listOfCategoryName",
                style: TextStyle(
                    color: AppColors.litePurple,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),


              const SizedBox(height: 10),
              Row(

                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "الحاله :",
                    style: TextStyle(
                        color: AppColors.litePurple,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),

                  Text(
                    "$listOfCategoryStatus",
                    style: TextStyle(
                        color: AppColors.litePurple,
                        fontFamily: 'Cairo',
                        fontSize: 18.sp),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: forMoreDetails,
                    child: Text(
                      "لمزيد من التفاصيل",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TableCalendar(
                                    calendarFormat: _calendarFormat,
                                    startingDayOfWeek:
                                    StartingDayOfWeek.sunday,
                                    focusedDay: _selectedDate,
                                    firstDay:
                                    DateTime(DateTime.now().year - 1),
                                    lastDay:
                                    DateTime(DateTime.now().year + 1),
                                    selectedDayPredicate: (date) {
                                      return isSameDay(_selectedDate, date);
                                    },
                                    onDaySelected: (date, events) {
                                      print(
                                          "on day selected ${date.toString()}");
                                      String formattedTime =
                                      DateFormat('yyy-MM-dd')
                                          .format(date);
                                      cubit.getItemFreeTimes(
                                          formattedTime, itemId);
                                      _selectedDate = date;
                                    },
                                    calendarStyle: const CalendarStyle(
                                      // weekendTextStyle: TextStyle(color: Colors.red),
                                      selectedTextStyle:
                                      TextStyle(color: Colors.white),
                                      selectedDecoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      // markersColor: Colors.green,
                                    ),
                                    headerStyle: const HeaderStyle(
                                      formatButtonVisible: true,
                                      titleCentered: true,
                                      titleTextStyle:
                                      TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon:const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.black,
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
