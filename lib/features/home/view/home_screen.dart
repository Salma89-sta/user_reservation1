import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Reservation/features/categories/business_layer/categories_cubit.dart';
import 'package:Reservation/features/home/view/reserved-card.dart';
import 'package:Reservation/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
import 'package:Reservation/features/user_resservation_detailss/view/edit_reservation.dart';
import '../../../colors/app_colors.dart';
import '../../../core/cache_helper/cache_helper.dart';
import '../../../core/network/api_url.dart';
import '../../../core/network/my_http.dart';
import '../../drawer/drawe_widget.dart';
import '../../notification/FirebaseApi.dart';
import '../business_layer/user_reservations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class HomeScreen extends StatefulWidget {
   HomeScreen({ Key? key }) : super( key: key );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseApi _noti = FirebaseApi();

  @override
   initState() {
    // TODO: implement initState
    _noti.initialize();
    // _noti.NotificationInitialization();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: BlocProvider(
        create: (context) => CategoryCubit()..getCategories(),
        child: DrawerWidget(),
      ),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.litePurple,
        title:const Center(child: Text("حجوزاتي", style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold),)),
      ),
      body: PopScope(
        onPopInvoked: (pop) async {
          var response = await MyHttp.post(endPoint: API.notificaion, data: {
            'id':CacheHelper.getData(key: 'id'),
            "token":CacheHelper.getData(key: 'fcmToken'),
          });

        },
        child: BlocConsumer<UserReservationsCubit, UserReservationsState>
          (
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = UserReservationsCubit.get(context);

            return (state is UserReservationsLoading)
                ? Center(child: CircularProgressIndicator())
                :
            (state is UserReservationsLoaded) ? Container(
              width: double.infinity,
              height: 100.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.userReservationsData.length,
                  itemBuilder: (context, index) {
                    return ReservedCardToUser(
                      reservedProductImage: cubit.userReservationsData[index].item!.image1.toString(),
                      reservedProductName: cubit.userReservationsData[index]
                          .categoryName.toString(),
                      fromDate: cubit.userReservationsData[index].timeOfReservationFrom.toString().replaceAll('00:00:00', ''),
                      toDate: cubit.userReservationsData[index].timeOfReservationTo.toString().replaceAll('00:00:00', ''),
                      status: cubit.userReservationsData[index].status
                          .toString(), ReservationId: cubit.userReservationsData[index].id!,

                      delete: () {
                      if( cubit.userReservationsData[index].status.toString() == '0'){
                        final cubit = UserReservationsCubit.get(context);
                        cubit.userDeleteReservation(cubit.userReservationsData[index].id!);
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=));

                      }else{
                        // Fluttertoast.showToast(msg: "هذا الحجز تمت الموافقه عليه لا يمكن مسحه", textColor: Colors.white, backgroundColor: Colors.deepOrange);

                      }
                    }, edit: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(
          create: (context) => AddReservationCubit(),
          child: EditReservationScreen(
                            itemId: cubit.userReservationsData[index].itemId!,
                            categoryName: cubit.userReservationsData[index].categoryName!,
                            reservationId:cubit.userReservationsData[index].id!,
                            status: cubit.userReservationsData[index].status!,
                            to: cubit.userReservationsData[index].timeOfReservationTo!,
            from:cubit.userReservationsData[index].timeOfReservationFrom!,
            additionals:cubit.userReservationsData[index].additionalOptions!,
            paid: cubit.userReservationsData[index].paid!,
            doc: cubit.userReservationsData[index].document!,
            approv: cubit.userReservationsData[index].approveOfPayment!,
            package_id: cubit.userReservationsData[index].packageId!,
            time: cubit.userReservationsData[index].time!, salary: cubit.userReservationsData[index].price!,),
        )));
                    },
                    );
                  }
              ),
            ) : Container(
              child: Center(
                child: Text("ليس لديك حجوزات"),
              ),
            );
          },
        ),
      ),
    );
  }
}
