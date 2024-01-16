// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:rservation_user/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
//
// import '../../../common/text-form-field.dart';
// import '../../drawer/drawe_widget.dart';
//
// class UpdateReservation extends StatelessWidget {
//   const UpdateReservation({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerWidget(),
//
//       appBar: AppBar(
//
//         backgroundColor: Colors.deepOrange,
//         title: Center(child: Text("تعديل الحجز", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold),)),
//       ),
//
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(right: 20),
//             alignment: AlignmentDirectional.topStart,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20,),
//                 Text("الاسم", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
//                 SizedBox(height: 5,),
//                 TextFormFieldWidget(
//                     prefix: Icon(Icons.people_outline),
//                     labelText: CacheHelper.getData(key: 'name')??"",
//                     IsObsecure: false,
//                     textFieldController:
//                     _nameController
//                 ),
//
//                 const SizedBox(height: 15,),
//                 Text("البريد الالكتروني", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
//                 SizedBox(height: 5,),
//                 TextFormFieldWidget(
//                     prefix: Icon(Icons.email_outlined),
//                     labelText: CacheHelper.getData(key: 'email')??"",
//                     IsObsecure: false,
//                     textFieldController:
//                     _emailController
//                 ),
//
//                 const SizedBox(height: 15,),
//                 Text("رقم الهويه", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
//                 SizedBox(height: 5,),
//                 TextFormFieldWidget(
//                     prefix: Icon(Icons.camera_front_outlined),
//                     labelText: CacheHelper.getData(key: 'nid')??"",
//                     IsObsecure: false,
//                     textFieldController:
//                     _nidController
//                 ),
//
//                 const SizedBox(height: 15,),
//                 Text("الرقم السري", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
//                 SizedBox(height: 5,),
//
//                 TextFormFieldWidget(
//                   prefix: Icon(Icons.lock_open),
//                   labelText: CacheHelper.getData(key: 'password')??"",
//                   IsObsecure: false,
//                   textFieldController:
//                   _passController,
//                 ),
//
//                 SizedBox(height: 15,),
//
//                 BlocConsumer<AddReservationCubit, AddReservationState>(
//                   listener: (context, state) {
//                     if(state is UserUpdateDataSuccess){
//                       Fluttertoast.showToast(msg: "تم تعديل البيانات بنجاح",textColor: Colors.white, backgroundColor: Colors.deepOrange);
//                       Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
//
//                     }
//                   },
//                   builder: (context, state) {
//                     return Button0(widget: Center(child: Text("تعديل", style: TextStyle(color: Colors.white,
//                         fontSize: 20.sp, fontFamily: 'Cairo', fontWeight: FontWeight.bold),)), function: (){
//
//                       print(".........try to update");
//                       final updateData = UserUpdateDataCubit.get(context);
//                       updateData.updateData(
//                         _nameController.text.toString().trim().isEmpty?
//                         CacheHelper.getData(key: 'name').toString():
//                         _nameController.text.toString() ,
//                         _emailController.text.toString().trim().isEmpty? CacheHelper.getData(key: 'emil').toString():_emailController.text.toString(),
//                         CacheHelper.getData(key: 'id').toString(),
//                         _nidController.text.toString().trim().isEmpty? CacheHelper.getData(key: 'nid').toString() :_nidController.text.toString(),
//                         _passController.text.toString().trim().isEmpty? CacheHelper.getData(key: 'password'):_passController.text.toString(),
//                       );
//
//                     }
//
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
