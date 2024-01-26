import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rservation_user/features/categories/business_layer/categories_cubit.dart';
import 'package:rservation_user/features/home/view/reserved-card.dart';
import 'package:rservation_user/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
import 'package:rservation_user/features/user_resservation_detailss/view/edit_reservation.dart';
import '../../drawer/drawe_widget.dart';
import '../business_layer/user_reservations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super( key: key );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocProvider(
        create: (context) => CategoryCubit()..getCategories(),
        child: DrawerWidget(),
      ),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepOrange,
        title:const Center(child: Text("حجوزاتي", style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold),)),
      ),
      body: BlocConsumer<UserReservationsCubit, UserReservationsState>
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
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cubit.userReservationsData.length,
                itemBuilder: (context, index) {
                  return ReservedCardToUser(
                    reservedProductImage: cubit.userReservationsData[index].item!.image1.toString(),
                    reservedProductName: cubit.userReservationsData[index]
                        .categoryName.toString(),
                    fromDate: cubit.userReservationsData[index].timeOfReservationFrom.toString(),
                    toDate: cubit.userReservationsData[index].timeOfReservationTo.toString(),
                    status: cubit.userReservationsData[index].status
                        .toString(), ReservationId: cubit.userReservationsData[index].id!,

                    delete: () {
                    if( cubit.userReservationsData[index].status.toString() == '0'){
                      final cubit = UserReservationsCubit.get(context);
                      cubit.userDeleteReservation(cubit.userReservationsData[index].id!);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=));

                    }else{
                      Fluttertoast.showToast(msg: "هذا الحجز تمت الموافقه عليه لا يمكن مسحه", textColor: Colors.white, backgroundColor: Colors.deepOrange);

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
    additionals:[],
    paid: cubit.userReservationsData[index].paid!,
    doc: cubit.userReservationsData[index].document!,
    approv: cubit.userReservationsData[index].approveOfPayment!,),
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
    );
  }
}
