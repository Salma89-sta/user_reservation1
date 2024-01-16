// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rservation_user/core/cache_helper/cache_helper.dart';
// import 'package:rservation_user/features/categories/business_layer/categories_cubit.dart';
// import 'package:rservation_user/features/home/business_layer/user_reservations_cubit.dart';
// import 'package:rservation_user/features/home/view/home_screen.dart';
//
// import '../features/categories/view/all_categories_wisget.dart';
//
// class SharedBottomNavigationBar extends StatefulWidget {
//   final List<Widget> pages=[
//     HomeScreen(),
//     ViewCategoriesScreen(),
//     ViewCategoriesScreen(),
//
//   ];
//
//   SharedBottomNavigationBar();
//
//   @override
//   _SharedBottomNavigationBarState createState() =>
//       _SharedBottomNavigationBarState();
// }
//
// class _SharedBottomNavigationBarState extends State<SharedBottomNavigationBar> {
//   int _currentIndex = 0;
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//       print(_currentIndex);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => CategoryCubit()..getCategories()),
//         BlocProvider(create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: "id"))),
//
//       ],
//       child: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: _onTabTapped,
//           items: [
//
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.notifications),
//               label: 'Notifications',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//         ),
//         body: widget.pages[_currentIndex] ,
//       ),
//     );
//   }
// }
