// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '/colors/app_colors.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// class CustomDropdown<T> extends StatelessWidget {
//   final List<DropdownMenuItem<T>> dropdownMenuItemList;
//   final ValueChanged onChanged;
//   final T value;
//   final bool isEnabled;
//   final String hint;
//   final Color borderColor;
//   final Color bgColor;
//   final bool isValidate;
//
//   const CustomDropdown({
//     Key? key,
//     required this.dropdownMenuItemList,
//     required this.onChanged,
//     required this.value,
//     this.hint = '',
//     this.isEnabled = true,
//     this.bgColor = Colors.white,
//     this.borderColor = AppColors.geryFontColors,
//     this.isValidate = true,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       ignoring: !isEnabled,
//       child: Container(
//         padding: const EdgeInsets.only( left:10 ,right: 10.0),
//         margin: const EdgeInsets.only( right: 10, top: 10),
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(15.0)),
//             border: Border.all(
//               color: isValidate ? borderColor : Colors.redAccent,
//               width: 1,
//             ),
//             color: isEnabled ? bgColor : Colors.grey.withAlpha(100)),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton(
//             icon: const Icon(
//               Icons.keyboard_arrow_down_sharp,
//               color: AppColors.contastColor,
//             ),
//             hint: Text(
//               hint,
//               style: const TextStyle(
//                   fontFamily: 'Cairo', color: AppColors.lightGrey),
//             ),
//             isExpanded: true,
//             itemHeight: 50.0,
//             style: TextStyle(
//                 fontSize: 12.sp,
//                 fontFamily: 'Cairo',
//                 color:
//                 isEnabled ? AppColors.mainPurpulColor : Colors.grey[700]),
//             items: dropdownMenuItemList,
//             onChanged: onChanged,
//             value: value,
//           ),
//         ),
//       ),
//     );
//   }
// }
