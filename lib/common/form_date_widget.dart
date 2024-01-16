// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// import '../colors/app_colors.dart';
//
// class DateSelectionField extends StatefulWidget {
//   final String? labelText;
//   final dynamic prefix;
//   final dynamic fillcolor;
//
//   DateSelectionField({this.labelText, this.prefix, this.fillcolor});
//
//   @override
//   _DateSelectionFieldState createState() => _DateSelectionFieldState();
// }
//
// class _DateSelectionFieldState extends State<DateSelectionField> {
//   DateTime? selectedDate;
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2023),
//       lastDate: DateTime(3100),
//     );
//
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = DateTime(picked.year, picked.month, picked.day);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 80.w,
//       height: 15.h,
//       child: GestureDetector(
//         onTap: () {
//           _selectDate(context);
//         },
//         child: AbsorbPointer(
//           child: TextFormField(
//             decoration: InputDecoration(
//               prefixIcon: widget.prefix,
//               suffixIcon: Icon(Icons.calendar_today, color: AppColors.lightGrey,
//                   ),
//               filled: true,
//               fillColor: widget.fillcolor,
//               floatingLabelStyle: TextStyle(color: Colors.deepOrange),
//               labelStyle: TextStyle(color: Colors.deepOrange),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   width: 2,
//                   color: Colors.deepOrange,
//                 ),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.lightGrey, width: 1.5),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               labelText: '',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(100),
//               ),
//             ),
//             controller: TextEditingController(
//               text: selectedDate != null
//                   ? selectedDate.toString().split(' ')[0]
//                   : '',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../colors/app_colors.dart';

DateTime fromDate= DateTime.now();  DateTime toDate= DateTime.now();

class DateSelectionField extends StatefulWidget {
  final String? labelText;
  final dynamic prefix;
  final dynamic fillcolor;
  bool isFrom;

  DateSelectionField({this.labelText, this.prefix, this.fillcolor, required this.isFrom});

  @override
  _DateSelectionFieldState createState() => _DateSelectionFieldState();
}

class _DateSelectionFieldState extends State<DateSelectionField> {
  DateTime? selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(3100),
    );

    if (picked != null && picked != selectedDateTime) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if(widget.isFrom == true){
            fromDate = selectedDateTime!;
          }else{
            toDate = selectedDateTime!;
          }
          print(selectedDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 15.h,
      child: TextButton(
        onPressed: () {
          _selectDateTime(context);
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              suffixIcon: Icon(
                Icons.calendar_today,
                color: AppColors.lightGrey,
              ),
              filled: true,
              fillColor: widget.fillcolor,
              floatingLabelStyle: TextStyle(color: Colors.deepOrange),
              labelStyle: TextStyle(color: Colors.deepOrange),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.deepOrange,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            controller: TextEditingController(
              text: selectedDateTime != null
                  ? selectedDateTime.toString()
                  : '',
            ),

          ),
        ),
      ),
    );
  }
}