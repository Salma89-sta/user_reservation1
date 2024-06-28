import 'package:flutter/material.dart';
import 'package:Reservation/common/button.dart';
import 'package:Reservation/common/text-form-field.dart';
import 'package:Reservation/features/home/business_layer/user_reservations_cubit.dart';
import 'package:Reservation/features/home/view/home_screen.dart';
import '../../../colors/app_colors.dart';
import '../../../core/cache_helper/cache_helper.dart';
import '../../drawer/drawe_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_layer/user_update_data_cubit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserUpdateDataScreen extends StatelessWidget {

   UserUpdateDataScreen({Key? key}) : super(key: key);

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _nidController = new TextEditingController();

  CacheHelper? prefs;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: DrawerWidget(),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        backgroundColor: AppColors.litePurple,
        title: Center(child: Text("تعديل البيانات الشخصيه", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold),)),
      ),
      body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(right: 20),
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Text("الاسم", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    TextFormFieldWidget(
                      prefix: Icon(Icons.people_outline),
                        labelText: CacheHelper.getData(key: 'name'),
                        IsObsecure: false,
                        textFieldController:
                        _nameController
                    ),
      
                    const SizedBox(height: 15,),
                    Text("البريد الالكتروني", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    TextFormFieldWidget(
                        prefix: Icon(Icons.email_outlined),
                        labelText: CacheHelper.getData(key: 'email'),
                        IsObsecure: false,
                        textFieldController:
                        _emailController
                    ),
      
                    const SizedBox(height: 15,),
                    Text("رقم الهويه", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    TextFormFieldWidget(
                        prefix: Icon(Icons.camera_front_outlined),
                        labelText: CacheHelper.getData(key: 'nid'),
                        IsObsecure: false,
                        textFieldController:
                        _nidController
                    ),
      
                    const SizedBox(height: 15,),
                    Text("الرقم السري", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
      
                    TextFormFieldWidget(
                      prefix: Icon(Icons.lock_open),
                      labelText: CacheHelper.getData(key: 'password'),
                        IsObsecure: false,
                        textFieldController:
                        _passController,
                    ),
      
         SizedBox(height: 15,),
      
         BlocConsumer<UserUpdateDataCubit, UserUpdateDataState>(
  listener: (context, state) {
    if(state is UserUpdateDataSuccess){
      print("update success");
      EasyLoading.dismiss();

      // Fluttertoast.showToast(msg: "تم تعديل البيانات بنجاح",textColor: Colors.white, backgroundColor: Colors.deepOrange);
      Navigator.push(context, MaterialPageRoute(builder: (_)=> BlocProvider(
        create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: 'id')),
        child: HomeScreen(),
      )));

    }else{
      print("update wrong ");
    }
  },
  builder: (context, state) {
    return Button0(widget: Center(child: Text("تعديل", style: TextStyle(color: Colors.white,
             fontSize: 20.sp, fontFamily: 'Cairo', fontWeight: FontWeight.bold),)), function: (){
      EasyLoading.show(status: 'loading...');

      print("try to update user data ");
print(CacheHelper.getData(key: 'email'));

      final updateData = UserUpdateDataCubit.get(context);
        updateData.updateData(
          name: _nameController.text.toString().trim().isEmpty?
          CacheHelper.getData(key: 'name').toString():
          _nameController.text.toString() ,
          email:  _emailController.text.toString().trim().isEmpty?
          CacheHelper.getData(key: 'email').toString():
          _emailController.text.toString(),
          id: CacheHelper.getData(key: 'id').toString(),
           nid: _nidController.text.toString().trim().isEmpty? CacheHelper.getData(key: 'nid').toString() :_nidController.text.toString(),
          password:  _passController.text.toString().trim().isEmpty? CacheHelper.getData(key: 'password'):_passController.text.toString(),
        );

        if(_nameController.text.trim().isNotEmpty){
          CacheHelper.saveData(key: 'name', value: _nameController.text);
        } if(_emailController.text.trim().isNotEmpty){
         CacheHelper.saveData(key: 'email', value: _emailController.text);
       } if(_passController.text.trim().isNotEmpty){
         CacheHelper.saveData(key: 'password', value: _passController.text);
       } if(_nidController.text.trim().isNotEmpty){
         CacheHelper.saveData(key: 'nid', value: _nidController.text);
       }
      
                    }
                    
      );
  },
),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
