import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/core/cache_helper/cache_helper.dart';
import 'package:Reservation/features/categories/business_layer/categories_cubit.dart';
import 'package:Reservation/features/categories/view/all_categories_wisget.dart';
import 'package:Reservation/features/home/view/home_screen.dart';
import 'package:Reservation/features/login/view/login.dart';
import 'package:Reservation/features/user_update_data/business_layer/user_update_data_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors/app_colors.dart';
import '../home/business_layer/user_reservations_cubit.dart';
import '../login/business_layer/login_cubit.dart';
import '../user_update_data/view/user_update_data_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  File? image;
String  email =CacheHelper.getData(key: 'email');
 String name= CacheHelper.getData(key: 'name');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "${name}",
                style: TextStyle(fontSize: 20.sp, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "${email}",
                style: TextStyle(fontSize: 16.sp, fontFamily: 'Cairo',fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: InkWell(
                onTap:_pickImage ,
                child: CircleAvatar(
                  child: ClipOval(
                    child: image != null ? Image.file(image!) : _buildPlaceholderIcon(),
                  ),
                ),
              ),
              decoration:const BoxDecoration(
                color: AppColors.litePurple
              ),

            ),
            ListTile(

              title:  Text('حجوزاتي', style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold, fontSize: 20.sp),),
              onTap: () {
                setState(() {});
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
        create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: "id")),
        child: HomeScreen(),
      ),
                          ),
                        );
              },
              leading:  Icon(Icons.format_list_bulleted, size: 20.sp,),

            ),
           const Divider(),
            ListTile(
              title:  Text('المنشآت ',style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold, fontSize: 20.sp),),
              onTap: () {
                setState(() {});
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
         BlocProvider(
        create: (context) => CategoryCubit()..getCategories(),
        child: ViewCategoriesScreen(),
      ),

                                ),
                              );
              },
              leading:  Icon(Icons.home_outlined,size: 20.sp,),

            ),
            const Divider(),

            ListTile(
              title:  Text('الملف الشخصي',style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold,fontSize: 20.sp),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>BlocProvider(
        create: (context) => UserUpdateDataCubit(),
        child: UserUpdateDataScreen(),
      )));
              },
              leading:  Icon(Icons.history_edu,size: 20.sp,),
            ),
            const Divider(),

            ListTile(
              title:  Text('تسجيل الخروج',style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold,fontSize: 20.sp),),
              onTap: () async {

                await CacheHelper.init();
                CacheHelper.clearAllData();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> LogIn()));
                print(CacheHelper.getData(key: 'id'));

              },
              leading:  Icon(Icons.output_outlined,size: 20.sp,),

            ),

            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return const Icon(
      Icons.person,
      size: 64,
      color:AppColors.litePurple,
    );
  }

  Future<void> _pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}