import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppBarWidget extends StatelessWidget {
  final String appText;
  final bool isHome;

   const AppBarWidget({Key? key, required this.appText, required this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black38,
        title: Center(child: Text(appText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        actions: <Widget>[
          IconButton(
            icon: IconButton(
              onPressed: () {
              },
              icon: isHome?
              const Icon(Icons.home_outlined, size: 30, color: AppColors.litePurple,)
                  :const Icon(Icons.home_outlined, size: 25, color: Colors.white,),
            ),
            tooltip: 'Home',
            onPressed: () {
            },
          ),
          const SizedBox(width: 50,),
          IconButton(
              icon: isHome?
           const Icon(Icons.category_outlined, size: 25, color: Colors.white,)
          :const Icon(Icons.category_outlined, size: 30, color:AppColors.litePurple,),
            tooltip: 'Categories',
            onPressed: () {
            }
          ),
          const SizedBox(width: 100,),

        ],

    );
  }
}
