//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../colors/app_colors.dart';
//
// class TextFormFieldWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final bool multiLines;
//   final String name;
//   final Color color;
//   final bool isNumber;
//   final Widget? suffix;
//
//   const TextFormFieldWidget(
//       {Key? key,
//         required this.controller,
//         required this.multiLines,
//         required this.name,
//         this.isNumber = false,
//         this.suffix,
//         this.color = AppColors.geryFontColors})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//         child: TextFormField(
//             showCursor: true,
//             cursorHeight: 30,
//             cursorColor: Colors.white,
//             style: TextStyle(
//                 color: color),
//             minLines: multiLines ? 6 : 1,
//             maxLines: multiLines ? 6 : 1,
//             controller: controller,
//             validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
//              ),);
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../colors/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextEditingController textFieldController = TextEditingController();
  dynamic prefix;
  dynamic suffix;
  dynamic fillcolor;
  String labelText = "";
  dynamic color;
  dynamic validator;
  late bool IsObsecure;
  TextFormFieldWidget(
      {required this.labelText,
         this.prefix,
          this.suffix,
        this.validator,
        required this.IsObsecure,
        required this.textFieldController,
          this.fillcolor,
         this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      child: TextFormField(
          style: TextStyle(height:1.8, color: Colors.deepOrange, fontWeight: FontWeight.w900),
          validator: validator,

          obscureText: IsObsecure,
          cursorColor: AppColors.lightGrey,
          controller: textFieldController,
          decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            filled: true,
            fillColor: fillcolor,
            floatingLabelStyle:  TextStyle(color:Colors.deepOrange),
            labelStyle: TextStyle(color: Colors.deepOrange),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.deepOrange,
              ),
              borderRadius: BorderRadius.circular(15),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:AppColors.lightGrey, width:1.5),
              borderRadius: BorderRadius.circular(15)
            ),
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100),
              //borderSide: BorderSide(color: Colors.white, width: 3)
            ),
          )),
    );
  }
}