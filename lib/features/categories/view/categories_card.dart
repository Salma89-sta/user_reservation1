import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryCard extends StatelessWidget {
   String categoryName;
   dynamic categoryImage;
   VoidCallback tapToCategory;
   CategoryCard({Key? key, required this.categoryName, required this.tapToCategory,required this.categoryImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap:tapToCategory ,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0,),
        child: Container(
          width: 30.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.5,
                blurRadius: 0.5,
              ),
            ],
          ),

          child: Column(
            children: [
              Image.network("${categoryImage}", width: 100.w, height: 15.h,fit: BoxFit.fill,),
              SizedBox(height: 10,),

              Center(child: Text("${categoryName}",style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20),)),
              SizedBox(height: 10,),



            ],
          ),
        ),
      ),
    );
  }
}
