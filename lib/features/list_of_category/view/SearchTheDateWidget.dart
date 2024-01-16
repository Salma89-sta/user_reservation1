// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:rservation_user/colors/app_colors.dart';
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
//
// class SearchDateWidget extends StatefulWidget {
//   @override
//   State<SearchDateWidget> createState() => _SearchDateWidgetState();
// }
//
// class _SearchDateWidgetState extends State<SearchDateWidget> {
//   dynamic pickedDate ;
//   String textAppear = "تحديد الموقع";
//   TextEditingController textFieldController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 85.w,
//       height: 10.h,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.lightGrey,
//             blurRadius: 25.0,
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 "${textAppear}",
//                 style: TextStyle(fontFamily: 'Cairo'),
//               ),
//               SingleChildScrollView(
//                 child: IconButton(
//                   onPressed: () async {
//                     pickedDate= await
//                     showDatePicker(context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2023, 1),
//                         lastDate: DateTime(5555));
//                     if (pickedDate!= null){
//                       setState(() {
//                         textAppear=  DateTime(pickedDate.year, pickedDate.month, pickedDate.day).toString();
//                       });
//                     }
//
//                   },
//                   icon: Icon(Icons.calendar_today),
//                 ),
//               )
//             ],
//           ),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 "${textAppear}",
//                 style: TextStyle(fontFamily: 'Cairo'),
//               ),
//               SingleChildScrollView(
//                 child: IconButton(
//                   onPressed: () async {
//                     pickedDate= await
//                     showDatePicker(context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2023, 1),
//                         lastDate: DateTime(5555));
//                     if (pickedDate!= null){
//                       setState(() {
//                         textAppear=  DateTime(pickedDate.year, pickedDate.month, pickedDate.day).toString();
//                       });
//                     }
//
//                   },
//                   icon: Icon(Icons.calendar_today),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../colors/app_colors.dart';

class SearchDate extends StatefulWidget {
// final String textLabel;
//
//   const SearchDate({super.key, required this.textLabel});


  @override
  _SearchDateState createState() => _SearchDateState();
}

class _SearchDateState extends State<SearchDate> {
  DateTime? selectedDate;
  dynamic? romDate;
  dynamic? toDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(3100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.lightGrey
        ),
        boxShadow: [BoxShadow(
          blurRadius: 0.25,
          color: Colors.white
        )]
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,


              children: [
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                      romDate= selectedDate.toString();

                    },
                    child: Column(
                      children: [
                        Text("الي تاريخ", style: TextStyle(fontFamily: 'Cairo'),),
                        AbsorbPointer(
                          child: Row(
                            children: [
                              Text(romDate != null
                                      ? romDate.toString().split(' ')[0]
                                      : '----:--:--',
                                ),
                              IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today)),

                            ],
                          ),
                          ),
                      ],
                    ),
                  ),
                ),

                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Column(
                      children: [
                        Text("من تاريخ", style: TextStyle(fontFamily: 'Cairo'),),
                        AbsorbPointer(
                          child: Row(
                            children: [
                              Text(selectedDate != null
                                  ? selectedDate.toString().split(' ')[0]
                                  : '----:--:--',
                              ),
                              IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today)),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: InkWell(
                onTap: (){},
                child: Text("بحث", style: TextStyle(color: Colors.black,decoration: TextDecoration.underline, fontFamily: 'Cairo',
                  fontSize: 20.sp,
                ),),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
