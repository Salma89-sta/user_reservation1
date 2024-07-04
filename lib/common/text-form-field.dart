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
  late bool? enable ;
  TextFormFieldWidget(
      {super.key, required this.labelText, this.prefix, this.suffix, this.validator,
        required this.IsObsecure, required this.textFieldController,
          this.fillcolor, this.color , this.enable});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: TextFormField(
          style: const TextStyle(height:1.8, color: AppColors.litePurple, fontWeight: FontWeight.w900),
          validator: validator,
          enabled: enable ?? true ,
          obscureText: IsObsecure,
          cursorColor: AppColors.lightGrey,
          controller: textFieldController,
          decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            filled: true,
            fillColor: fillcolor,
            floatingLabelStyle:  const TextStyle(color:AppColors.litePurple),
            labelStyle: const TextStyle(color: AppColors.litePurple),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: AppColors.litePurple,
              ),
              borderRadius: BorderRadius.circular(10),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:AppColors.lightGrey, width:1.5),
              borderRadius: BorderRadius.circular(10)
            ),
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              //borderSide: BorderSide(color: Colors.white, width: 3)
            ),
          )),
    );
  }
}