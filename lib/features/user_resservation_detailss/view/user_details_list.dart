// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:rservation_user/colors/app_colors.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:rservation_user/core/cache_helper/cache_helper.dart';
// import 'package:rservation_user/features/list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
// import 'package:rservation_user/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
// import '../../../common/button.dart';
// import '../../../common/check_list_widget.dart';
// import '../../../common/form_date_widget.dart';
// import '../../../common/text-form-field.dart';
// import 'attachment_pickker.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class UserDetailsList extends StatelessWidget {
//   String categoryName;
//   String itemID;
//   TextEditingController _nameEditingController= TextEditingController();
//   TextEditingController _phoneEditingController= TextEditingController();
//   TextEditingController _attuEditingController= TextEditingController();
//
//
//   String totalSalary="100";
//
//   UserDetailsList({Key? key, required this.categoryName, required this.itemID}) : super(key: key);
//   static List<String> status=[
//     "أعزب",
//     "متزوج"
//   ];
//
//   String? statusIndex;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.white,),),
//         backgroundColor: Colors.deepOrange,
//         title: Center(child: Text("استكمال بيانات الحجز", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold),)),
//       ),
//       body: BlocConsumer<AddReservationCubit, AddReservationState>(
//   listener: (context, state) {
//     // TODO: implement listener
//   },
//   builder: (context, state) {
//     return SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height:15),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: Text(
//                   "الاسم",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//
//             Container(
//               child: TextFormFieldWidget(
//                 labelText: "",
//                 prefix: null,
//                 suffix: Icon(
//                   Icons.perm_identity,
//                   color: AppColors.lightGrey,
//                 ),
//                 IsObsecure: false,
//                 textFieldController: _nameEditingController,
//                 color: AppColors.lightGrey,
//                 fillcolor: Colors.white,
//               ),
//             ),
//             const SizedBox(height:15),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: Text(
//                   "رقم الهاتف",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               child: TextFormFieldWidget(
//                 labelText: "",
//                 prefix: null,
//                 suffix:const Icon(
//                   Icons.call,
//                   color: AppColors.lightGrey,
//                 ),
//                 IsObsecure: false,
//                 textFieldController: _phoneEditingController,
//                 color: AppColors.lightGrey,
//                 fillcolor: Colors.white,
//               ),
//             ),
//             const SizedBox(height:15),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child:const Text(
//                   "الحاله الاجتماعيه",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             // DropDownListWidget(),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20),
//               child: Container(
//                 alignment: AlignmentDirectional.topEnd,
//                 width: 80.w,
//                 height: 10.h,
//                 child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: DropdownButtonFormField<int>(
//                     decoration:const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                     ),
//                     isExpanded: true,
//                     hint: const Text(
//                       "الحالة الاجتماعية",
//                       style: TextStyle(color: AppColors.lightGrey),
//                     ),
//                     items: status.map((value) {
//                       return DropdownMenuItem<int>(
//                         value: status.indexOf(value),
//                         child: Container(
//                           width: 80.w,
//                           child: Text(
//                             value,
//                             style: TextStyle(
//                               color: AppColors.lightGrey,
//                               fontFamily: 'Cairo',
//                               fontSize: 19.sp
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (int? value) {
//                       statusIndex = value.toString();
//                       print(".................................");
//                      print(value);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height:15),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: Text(
//                   " من  تارخ ",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//
//             DateSelectionField(
//               fillcolor: Colors.white, isFrom: true,),
//             // SizedBox(height:15),
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: Text(
//                   " الي  تاريخ  ",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//
//             DateSelectionField(fillcolor: Colors.white,isFrom: false,),
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: const Text(
//                   " مرفق ",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             AttachmentPickerWidget(isPaied: false,),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child:const Text(
//                   " ايصال دفع ",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             AttachmentPickerWidget(isPaied: true,),
//
//
//             const SizedBox(height: 15,),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0, bottom: 10),
//               child: Container(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child:const Text(
//                   "الاضافات",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: AppColors.lightGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5,),
//             BlocProvider(
//   create: (context) => AdditionalOptionsCubit()..getAdditionalOptions(itemID),
//   child: ChecklistPage(),
// ),
//             const SizedBox(height: 15,),
//
//             BlocConsumer<AddReservationCubit, AddReservationState>(
//   listener: (context, state) {
//     // TODO: implement listener
//   },
//   builder: (context, state) {
//     return Button0(
//               widget: Center(
//                 child: Text(
//                   "تأكيد الحجز",
//                   style: TextStyle(
//                     color: Colors.indigo,
//                     fontFamily: 'Cairo',
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               function: () {
//                 print("....................................rom to ...............");
//                 print(fromDate);
//                 print(toDate);
//                 final reservation = AddReservationCubit.get(context);
//                 reservation.addReservation(
//                   CacheHelper.getData(key: 'id'),
//                   categoryName,
//                   itemID,
//                   DateTime.now().toString(),
//                   fromDate.toString(),
//                   toDate.toString(),
//                   forPaid.toString(),
//                   forMatrial.toString(),
//                   '100',
//                   '0',
//                   'additionalOp',
//                   statusIndex.toString(),
//                 );
//
//                 print("ta2keed");
//
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('السعر'),
//                       content: Text('$totalSalary'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             // Close the dialog
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('الغاء'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//
//                           },
//                           child: Text('تأكيد الحجز'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             );
//   },
// ),
//             SizedBox(height: 15,),
//
//
//
//           ],
//         ),
//       );
//   },
// ),
//     );
//   }
// }
//
//
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rservation_user/common/button.dart';
import 'package:rservation_user/common/snack_bar_widget.dart';
import 'package:rservation_user/core/cache_helper/cache_helper.dart';
import 'package:rservation_user/features/home/business_layer/user_reservations_cubit.dart';
import 'package:rservation_user/features/home/view/home_screen.dart';
import 'package:rservation_user/features/list_of_category/business_layer/items_cubit.dart';
import 'package:rservation_user/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../colors/app_colors.dart';
import '../../../common/check_list_widget.dart';
import '../../list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../list_of_category_details/data_layer/additional_options_model.dart';

class AddReservationScreen extends StatefulWidget {

  String categoryName;
  String itemId;

  AddReservationScreen({required this.itemId, required this.categoryName});

  @override
  _AddReservationScreenState createState() => _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen> {
  List<String> selectedItems = [];
  List<Data>? checklistItems;

  final _formKey = GlobalKey<FormState>();

  final _fromDateTimeController = TextEditingController();
  final _toDateTimeController = TextEditingController();
  File? _attachment;

  static List<String> status=[
    "أعزب",
    "متزوج"
  ];
  String? statusIndex;
  @override
  void dispose() {

    _fromDateTimeController.dispose();
    _toDateTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectAttachment() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _attachment = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDateTime(TextEditingController controller) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final dateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
        controller.text = formattedDateTime;
      }
    }
  }

  void toggleItemSelection(int index, bool value) {
    setState(() {
      final item = checklistItems![index];
      if (value) {
        selectedItems.add(item.name.toString()); // Assuming 'title' is the item property to display as checklist item
      } else {
        selectedItems.remove(item.name.toString());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),),
        backgroundColor: Colors.deepOrange,
        title: Center(child: Text("استكمال بيانات الحجز", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold),)),
      ),
      body: BlocConsumer<AdditionalOptionsCubit, AdditionalOptionsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    final addOp = AdditionalOptionsCubit.get(context);

    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
        
              children: [
                Padding(
                padding: const EdgeInsets.only(right: 50.0, bottom: 10),
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child:const Text(
                    "الحاله الاجتماعيه",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: AppColors.lightGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // DropDownListWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Container(
                  alignment: AlignmentDirectional.topEnd,
                  width: 80.w,
                  height: 10.h,
                  child: DropdownButtonFormField<int>(
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      "الحالة الاجتماعية",
                      style: TextStyle(color: AppColors.lightGrey),
                    ),
                    items: status.map((value) {
                      return DropdownMenuItem<int>(
                        value: status.indexOf(value),
                        child: Container(
                          width: 80.w,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: AppColors.lightGrey,
                              fontFamily: 'Cairo',
                              fontSize: 19.sp
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      statusIndex = value.toString();
                      print(".................................");
                     print(value);
                    },
                  ),
                ),
              ),
        
                const SizedBox(height: 15,),
                Padding(
                padding: const EdgeInsets.only(right: 50.0, bottom: 10),
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child:const Text(
                    " من تاريخ /وقت ",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: AppColors.lightGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                    controller: _fromDateTimeController,
                    readOnly: true,
                    onTap: () => _selectDateTime(_fromDateTimeController),
                    decoration: InputDecoration(
                      labelText: '',
                      suffixIcon: Icon(Icons.calendar_today),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.indigo,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:AppColors.lightGrey, width:1.5),
                          borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select a from date and time';
                      }
                      return null;
                    },
                  ),
                ),
        
                const SizedBox(height: 15,),
        
                Padding(
                padding: const EdgeInsets.only(right: 50.0, bottom: 10),
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child:const Text(
                    " الي تاريخ و وقت ",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: AppColors.lightGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: TextFormField(
                    controller: _toDateTimeController,
                    readOnly: true,
                    onTap: () => _selectDateTime(_toDateTimeController),
                    decoration: InputDecoration(
                      labelText: '',
                      suffixIcon: Icon(Icons.calendar_today),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.indigo,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:AppColors.lightGrey, width:1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select a to date and time';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.only(right: 50.0, bottom: 10),
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child:const Text(
                      "الاضافات",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.lightGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: addOp.options.length,
                    itemBuilder: (context, index) {
                      final option = addOp.options[index];
                      final itemName = option.name.toString();
                      final itemPrice = option.price.toString();

                      return CheckboxListTile(
                        title: Text(
                          '$itemPrice   $itemName',
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

        
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0, bottom: 10),
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child:const Text(
                      "أضافه مرفق",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.lightGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
        
                Container(
                  width: 80.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.lightGrey
                    ),
                  ),
                  child: TextButton(
                    onPressed: _selectAttachment,
                    child: Text('اختر مرفق'),
                  ),
                ),
                if (_attachment != null) Image.file(_attachment!),
        
                const SizedBox(height: 15,),
        
                BlocConsumer<AddReservationCubit, AddReservationState>(
  listener: (context, state) {
    if(state is AddReservationSuccessfully){

      Fluttertoast.showToast(msg: "تم الحجز بنجاح", textColor: Colors.white, backgroundColor: Colors.deepOrange);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(
        create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: 'id')),
        child: HomeScreen(),
      )));

    }else if(state is AddReservationFailed){
      Fluttertoast.showToast(msg: "حدث مشكله اثناء الحجز ", textColor: Colors.white, backgroundColor: Colors.deepOrange);

    }
  },
  builder: (context, state) {
    return Button0(widget: Center(child: Text('تأكيد الحجز', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),)), 
                    function: (){
      print(selectedItems.toString());
      if (_formKey.currentState!.validate()) {
        final cubit = AddReservationCubit.get(context);
        cubit.addReservation(

            doc: _attachment.toString(),
            userId: CacheHelper.getData(key: 'id'),
            categoryName: widget.categoryName,
            itemId: widget.itemId,
            time: DateTime.now().toString(),
            from: _fromDateTimeController.text,
            to: _toDateTimeController.text,
            price: '',
            additionalOp: selectedItems.toString(),
            maritalStatus: statusIndex.toString()
        );
      };

                });
  },
)
        
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}