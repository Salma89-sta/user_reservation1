import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../colors/app_colors.dart';


String? forPaid;
String? forMatrial;

class AttachmentPickerWidget extends StatefulWidget {
  @override
  bool isPaied;

  AttachmentPickerWidget({super.key, required this.isPaied});

  _AttachmentPickerWidgetState createState() => _AttachmentPickerWidgetState();
}

class _AttachmentPickerWidgetState extends State<AttachmentPickerWidget> {




  Future<void> _openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          if(widget.isPaied == true)
            {
             forPaid =  result.files.single.path;
            }else{
            forMatrial = result.files.single.path;

          }
        });
      }
    } catch (e) {
      print('Error while picking attachment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        _openFilePicker();
      },
      child: Container(

        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrey,
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        width: 80.w,
          height: 10.h,
          child: Center(
              child: Text(
                ' أضافه رفق',
                style: TextStyle(fontFamily: 'Cairo', color: Colors.black),)),

      ),
    );
  }
}