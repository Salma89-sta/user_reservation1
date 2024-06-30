import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/colors/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Reservation/core/cache_helper/cache_helper.dart';
import 'package:Reservation/features/home/business_layer/user_reservations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Reservation/features/home/view/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ReservedCardToUser extends StatelessWidget {
  final dynamic reservedProductImage;
  final String reservedProductName;
  final String fromDate;
  final String toDate;
  final String status;
  final String ReservationId;
  VoidCallback edit;
  VoidCallback delete;


  ReservedCardToUser({required this.delete,required this.edit,Key? key,required this.reservedProductImage, required this.reservedProductName, required this.fromDate, required this.toDate, required this.status, required this.ReservationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Center(
        child: Container(
          width: 75.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border:Border.all(
          color: AppColors.litePurple,
            width:2,

        ),


          ),

          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: reservedProductImage,
                  width: 100.w,
                  height: 20.h,
                  placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,// Error widget
                ),
              ),
              Text("${reservedProductName}", style: TextStyle(color: AppColors.litePurple,
                  fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
             const SizedBox(height: 5,),

              Row(
                children: [
                  Text(" من : ", style: TextStyle(color: AppColors.litePurple, fontFamily: 'Cairo',fontSize: 20.sp),),

                  Text("${fromDate}", style: TextStyle(color: Colors.black, fontFamily: 'Cairo',fontSize: 18.sp),),
                ],
              ),
              const SizedBox(height: 5,),

              Row(

                children: [
                  Text(" الي : ", style: TextStyle(color:AppColors.litePurple, fontFamily: 'Cairo',fontSize: 20.sp),),

                  Text("${toDate}", style: TextStyle(color: Colors.black, fontFamily: 'Cairo',fontSize: 18.sp),),

                ],
              ),
             const  SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.,
                children: [

                  InkWell(
                    onTap: (){
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog( // <-- SEE HERE
                            content: SingleChildScrollView(
                              child: ListBody(
                                children:  <Widget>[
                                  Center(child: Text((status == '0')?"في الانتظار": "تمت الموافقه")),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Center(
                                child: TextButton(
                                  child: const Text('رجوع'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),

                            ],
                          );
                        },
                      );

                    },
                    child: Text(" متابعه حاله الحجز ",
                      style: TextStyle(color: Colors.black,
                        fontFamily: 'Cairo',fontSize: 18.sp,decoration: TextDecoration.underline,
                    ), ),
                  ),

                  IconButton(onPressed:edit, icon:const  Icon(Icons.edit, color: AppColors.lightGrey,)),
                  BlocConsumer<UserReservationsCubit, UserReservationsState>(
  listener: (context, state) {
    if(state is UserDeleteReservationSuccess){
      Fluttertoast.showToast(msg: "تم الغاء الحجز", textColor: Colors.white, backgroundColor:AppColors.litePurple);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(
  create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: 'id')),
  child: HomeScreen(),
)));
    }else{
      Fluttertoast.showToast(msg: "حدث خطا اثناء الالغاء", textColor: Colors.white, backgroundColor: AppColors.litePurple);

    }
  },
  builder: (context, state) {
    return IconButton(onPressed: delete, icon: Icon(Icons.delete, color: AppColors.lightGrey,));
  },
),

                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
