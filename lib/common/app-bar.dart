import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String appText;
  final bool isHome;

   AppBarWidget({Key? key, required this.appText, required this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black38,
        title: Center(child: Text(appText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        actions: <Widget>[
          IconButton(
            icon: IconButton(
              onPressed: () {
              },
              icon: isHome?
              Icon(Icons.home_outlined, size: 30, color: Colors.deepOrange,)
                  :Icon(Icons.home_outlined, size: 25, color: Colors.white,),
            ),
            tooltip: 'Home',
            onPressed: () {
            },
          ),
          SizedBox(width: 50,),
          IconButton(
              icon: isHome?
           Icon(Icons.category_outlined, size: 25, color: Colors.white,)
          :Icon(Icons.category_outlined, size: 30, color: Colors.deepOrange,),
            tooltip: 'Categories',
            onPressed: () {
            }
          ),
          SizedBox(width: 100,),

        ],

    );
  }
}
