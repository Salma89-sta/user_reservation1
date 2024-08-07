import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intlDateFormat;
import 'package:Reservation/common/button.dart';
import 'package:Reservation/core/cache_helper/cache_helper.dart';
import 'package:Reservation/features/home/business_layer/user_reservations_cubit.dart';
import 'package:Reservation/features/home/view/home_screen.dart';
import 'package:Reservation/features/list_of_category_details/item_package_business_layer/item_package_cubit.dart';
import 'package:Reservation/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/functions/salary_function.dart';
import '../../../colors/app_colors.dart';
import '../../list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../list_of_category_details/data_layer/additional_options_model.dart';

class AddReservationScreen extends StatefulWidget {
  String categoryName;
  String itemId;
  // String pricePer;
  // String price;
  String offer;

  AddReservationScreen(
      {super.key, required this.itemId,
      required this.categoryName,
      // required this.price,
      // required this.pricePer,
      required this.offer});

  @override
  _AddReservationScreenState createState() => _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen> {
  List<String> selectedItems = [];
  List<String> selectedItemsPrice = [];

  List<Data>? checklistItems;
  String? selectedPackage;

  final _formKey = GlobalKey<FormState>();
  String? packageId;
  late DateTime fromDate;
  late DateTime toDate;
  final _fromDateTimeController = TextEditingController();
  final _toDateTimeController = TextEditingController();
  final _notesController = TextEditingController();
  Widget? button = Text(
    'تأكيد الحجز',
    style: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold),
  );
  File? _attachment;
  String? salary;
  static List<String> status = ["أعزب", "متزوج"];
  String? statusIndex;

  @override
  void dispose() {
    _fromDateTimeController.dispose();
    _toDateTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectAttachment() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _attachment = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(TextEditingController controller , String condition) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3000)),
    );

    if (selectedDate != null) {
      final formattedDate = intlDateFormat.DateFormat('yyyy-MM-dd').format(selectedDate);

      controller.text = formattedDate;

      if(condition =='to'){
        toDate = selectedDate;
      }else{
        fromDate = selectedDate;
      }
    }
  }

  void toggleItemSelection(int index, bool value) {
    setState(() {
      final item = checklistItems![index];
      if (value) {
        selectedItems.add(item.name.toString());
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
          icon:const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.litePurple,
        title: Center(
            child: Text(
          "استكمال بيانات الحجز",
          style: TextStyle(
            fontSize: 20.sp,
              color: Colors.white,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,

          ),
        )),
      ),
      body: BlocConsumer<AdditionalOptionsCubit, AdditionalOptionsState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          final addOp = AdditionalOptionsCubit.get(context);

          return SingleChildScrollView(
            child: Padding(
              padding:const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Padding(
                      padding:const  EdgeInsets.only(right: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          RichText(
                            text:const TextSpan(
                              text: "الحاله الاجتماعيه",
                              style:  TextStyle(
                              fontFamily: 'Cairo',
                        color: AppColors.litePurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                              children: <TextSpan>[
                                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),

                          //  Text(
                          //   "الحاله الاجتماعيه",
                          //   // textAlign: TextAlign.start,
                          //   style: TextStyle(
                          //     fontFamily: 'Cairo',
                          //     color: AppColors.litePurple,
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    // DropDownListWidget(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Directionality(
                        textDirection: TextDirection.rtl,

                        child: DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            "الحالة الاجتماعية", textAlign: TextAlign.end,
                          ),
                          items: status.map((value) {
                            return DropdownMenuItem<int>(
                              value: status.indexOf(value),
                              child: SizedBox(
                                width: 80.w,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      // color: AppColors.lightGrey,
                                      fontFamily: 'Cairo',
                                      fontSize: 17.sp,
                                    fontWeight: FontWeight.bold
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

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child:  RichText(
                          text:const TextSpan(
                            text: "من تاريخ",
                            style:  TextStyle(
                              fontFamily: 'Cairo',
                              color: AppColors.litePurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),

                        // const Text(
                        //   " من تاريخ  ",
                        //   textAlign: TextAlign.end,
                        //   style: TextStyle(
                        //     fontFamily: 'Cairo',
                        //     color: AppColors.litePurple,
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: TextFormField(
                        controller: _fromDateTimeController,
                        readOnly: true,
                        onTap: () => _selectDate(_fromDateTimeController,'from'),
                        decoration: InputDecoration(
                          labelText: '',
                          suffixIcon:const Icon(Icons.calendar_today),
                          focusedBorder: OutlineInputBorder(
                            borderSide:const BorderSide(
                              width: 2,
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:const BorderSide(
                                color: AppColors.lightGrey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child:  RichText(
                          text:const TextSpan(
                            text: "الي تاريخ",
                            style:  TextStyle(
                              fontFamily: 'Cairo',
                              color: AppColors.litePurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),

                        // const Text(
                        //   " الي تاريخ ",
                        //   textAlign: TextAlign.end,
                        //   style: TextStyle(
                        //     fontFamily: 'Cairo',
                        //     color: AppColors.litePurple,
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: TextFormField(
                        controller: _toDateTimeController,
                        readOnly: true,
                        onTap: () => _selectDate(_toDateTimeController,'to'),
                        decoration: InputDecoration(
                          labelText: '',
                          suffixIcon:const Icon(Icons.calendar_today),
                          focusedBorder: OutlineInputBorder(
                            borderSide:const BorderSide(
                              width: 2,
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:const BorderSide(
                                color: AppColors.lightGrey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),

                    Padding(
                      padding:const EdgeInsets.only(right: 20),
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child:
                        RichText(
                          text:const TextSpan(
                            text: "اختيار الميعاد",
                            style:  TextStyle(
                              fontFamily: 'Cairo',
                              color: AppColors.litePurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),

                        // const Text(
                        //   " اختيار المعاد ",
                        //   textAlign: TextAlign.end,
                        //   style: TextStyle(
                        //     fontFamily: 'Cairo',
                        //     color: AppColors.litePurple,
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ),
                    BlocConsumer<ItemPackageCubit, ItemPackageState>(
                      listener: (context, state) {
                      },
                      builder: (context, state) {
                        var cubit = ItemPackageCubit.get(context);
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            alignment: AlignmentDirectional.topStart,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.availabilityData.length,
                              itemBuilder: (context, index) {
                                final from = cubit
                                    .availabilityData[index].availableTimeFrom;
                                final to = cubit
                                    .availabilityData[index].availableTimeTo;
                                String price = cubit
                                    .availabilityData[index].price
                                    .toString();
                                final id = cubit.availabilityData[index].id;

                                return RadioListTile(
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.end,
                                        'من الساعه: $from',
                                        style: TextStyle(

                                          fontFamily: 'Cairo',
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      Text(
                                        textAlign: TextAlign.end,
                                        'الي الساعه: $to ',
                                        style: TextStyle(

                                          fontFamily: 'Cairo',
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      Text(
                                        textAlign: TextAlign.end,
                                        'السعر: $price',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      const SizedBox(height: 10,)
                                    ],
                                  ),
                                  value: id,
                                  groupValue: selectedPackage,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPackage = id;
                                      salary = price.toString();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: const Text(
                          " ملاحظات ",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: AppColors.litePurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: TextFormField(
                        maxLines: 5,
                        controller: _notesController,
                        decoration: InputDecoration(
                          labelText: '',
                          suffixIcon:const Icon(Icons.notes),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.indigo,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:const BorderSide(
                                color: AppColors.lightGrey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 20, top: 20),
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: const Text(
                          "الاضافات",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: AppColors.litePurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Container(
                        alignment: AlignmentDirectional.topStart,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: addOp.options.length,
                          itemBuilder: (context, index) {
                            final option = addOp.options[index];
                            final itemName = option.name.toString();
                            final itemPrice = option.price.toString();

                            if(addOp.options.isEmpty){
                              return Center(child: Text("لا يوجد",  style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),),);

                            }else{
                              return Directionality(

                                textDirection: TextDirection.rtl,
                                child: CheckboxListTile(
                                  title: Text(
                                    ' $itemName ,السعر : $itemPrice ',
                                    style: TextStyle(
                                      // color: Colors.indigo,
                                      fontFamily: 'Cairo',
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  value: selectedItems.contains(itemName),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedItems.add(itemName);
                                        selectedItemsPrice.add(itemPrice);
                                      } else {
                                        selectedItems.remove(itemName);
                                        selectedItemsPrice.add(itemPrice);
                                      }
                                    });
                                  },
                                ),
                              );
                            }


                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                      child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: const Text(
                          "أضافه مرفق",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: AppColors.litePurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 80.w,
                      // height: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                      child: TextButton(
                        onPressed: _selectAttachment,
                        child: Text('برجاء اضافه قسميه الجواز اذا كانت الحاله الاجتماعيه متزوج', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.litePurple, fontSize: 20.sp),),
                      ),
                    ),
                    if (_attachment != null) Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.file(_attachment!),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    BlocConsumer<AddReservationCubit, AddReservationState>(
                      listener: (context, state) {
                        if (state is AddReservationSuccessfully) {
                          EasyLoading.dismiss();
                          Fluttertoast.showToast(
                              msg: "تم الحجز بنجاح",
                              textColor: Colors.white,
                              backgroundColor:  AppColors.litePurple);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            UserReservationsCubit()
                                              ..getUserReservations(
                                                  CacheHelper.getData(
                                                      key: 'id')),
                                        child: const HomeScreen(),
                                      )));
                        } else if (state is AddReservationFailed) {
                          EasyLoading.dismiss();
                          //
                          Fluttertoast.showToast(
                              msg: "حدث مشكله اثناء الحجز ",
                              textColor: Colors.white,
                              backgroundColor: AppColors.litePurple);
                        }else if(state is AddReservationAlreadyReserved){
                          EasyLoading.dismiss();

                          Fluttertoast.showToast(
                              msg: "هذا التوقيت غير متاح",
                              textColor: Colors.white,
                              backgroundColor:  AppColors.litePurple);
                        }else{
                          EasyLoading.show();

                        }
                      },
                      builder: (context, state) {
                        return Button0(
                            widget: Center(
                                child:button),
                            function: () {

                              if( statusIndex != null
                              ){
                                if(fromDate.isBefore(toDate)){
                                  if(statusIndex == 0){
                                    if (_formKey.currentState!.validate()) {


                                      double totalSalary = calculateTotalSalary(
                                          selectedItemsPrice, double.parse(salary!));
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {

                                          return AlertDialog(
                                            title: Center(child: Column(
                                              children: [
                                                const Text('السعر'),
                                                Text(totalSalary.toString()),
                                              ],
                                            )),
                                            // content: Text(totalSalary.toString()),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('غلق'),
                                              ),
                                              SizedBox(width: 20.w,),
                                              TextButton(
                                                onPressed: () {
                                                  print(_fromDateTimeController.text);
                                                  final cubit = AddReservationCubit.get(context);
                                                  cubit.addReservation(
                                                    doc: _attachment.toString(),
                                                    userId: CacheHelper.getData(key: 'id'),
                                                    categoryName: widget.categoryName,
                                                    itemId: widget.itemId,
                                                    time: DateTime.now().toString(),
                                                    from: "${_fromDateTimeController.text} 00:00:00",
                                                    to: '${_toDateTimeController.text} 00:00:00',
                                                    price: salary.toString(),
                                                    additionalOp: selectedItems.toString(),
                                                    maritalStatus: statusIndex.toString(),
                                                    offer: widget.offer,
                                                    comment: _notesController.text,
                                                    packageId:selectedPackage.toString(),
                                                  );
                                                },
                                                child:const Text('تأكيد الحجز'),
                                              ),
                                            ],
                                          );
                                        },
                                      );


                                    }
                                  }else if (statusIndex == 1){
                                    if (_formKey.currentState!.validate()){


                                      double totalSalary = calculateTotalSalary(
                                          selectedItemsPrice, double.parse(salary!));
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {

                                          return AlertDialog(
                                            title: Center(child: Column(
                                              children: [
                                                const Text('السعر'),
                                                Text(totalSalary.toString()),
                                              ],
                                            )),
                                            // content: Text(totalSalary.toString()),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('غلق'),
                                              ),
                                              SizedBox(width: 20.w,),
                                              TextButton(
                                                onPressed: () {
                                                  print(_fromDateTimeController.text);
                                                  final cubit = AddReservationCubit.get(context);
                                                  cubit.addReservation(
                                                    doc: _attachment.toString(),
                                                    userId: CacheHelper.getData(key: 'id'),
                                                    categoryName: widget.categoryName,
                                                    itemId: widget.itemId,
                                                    time: DateTime.now().toString(),
                                                    from: "${_fromDateTimeController.text} 00:00:00",
                                                    to: '${_toDateTimeController.text} 00:00:00',
                                                    price: salary.toString(),
                                                    additionalOp: selectedItems.toString(),
                                                    maritalStatus: statusIndex.toString(),
                                                    offer: widget.offer,
                                                    comment: _notesController.text,
                                                    packageId:selectedPackage.toString(),
                                                  );
                                                },
                                                child:const Text('تأكيد الحجز'),
                                              ),
                                            ],
                                          );
                                        },
                                      );


                                    }
                                                                    }
                                }else{
                                  Fluttertoast.showToast(msg: "برجاء التاكد من اختيار الميعاد بشكل صحيح", textColor: Colors.white, backgroundColor:AppColors.litePurple);

                                }


                              }else {
                                Fluttertoast.showToast(msg: "برجاء ملئ جميع البيانات المطلوبه", textColor: Colors.white, backgroundColor:AppColors.litePurple);

                              }
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
