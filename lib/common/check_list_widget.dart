// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:rservation_user/common/button.dart';
//
// class ChecklistPage extends StatefulWidget {
//   @override
//   _ChecklistPageState createState() => _ChecklistPageState();
// }
//
// class _ChecklistPageState extends State<ChecklistPage> {
//   List<dynamic> checklistItems = ['nm','nn','nnoi','pip']; // List to store the checklist items
//   List<dynamic> selectedItems = []; // List to store the selected items
//
//   @override
//   void initState() {
//     super.initState();
//     // fetchData(); // Fetch data from API when the page loads
//   }
//
//   // Future<void> fetchData() async {
//   //   // Make an HTTP request to fetch data from the API
//   //   final response = await http.get(Uri.parse('https://your-api-endpoint.com/checklist'));
//   //
//   //   if (response.statusCode == 200) {
//   //     // Parse the JSON response
//   //     final data = jsonDecode(response.body);
//   //
//   //     setState(() {
//   //       checklistItems = data['items'];
//   //     });
//   //   } else {
//   //     // Handle error if the API request fails
//   //     print('Failed to fetch data: ${response.statusCode}');
//   //   }
//   // }
//
//   void toggleItemSelection(int index, bool value) {
//     setState(() {
//       if (value) {
//         selectedItems.add(checklistItems[index]);
//       } else {
//         selectedItems.remove(checklistItems[index]);
//       }
//     });
//   }
//
//   void saveSelectedData() {
//     // Perform actions to save the selected data
//     print('Selected Items: $selectedItems');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       width: 80.w,
//       child: Column(
//           children: [
//             Container(
//               width: 80.w,
//               child: ListView.builder(
//                 itemCount: checklistItems.length,
//                 itemBuilder: (context, index) {
//                   final item = checklistItems[index];
//
//                   return CheckboxListTile(
//                     title: Text(item['title']),
//                     value: selectedItems.contains(item),
//                     onChanged: (value) {
//                       toggleItemSelection(index, value!);
//                     },
//                   );
//                 },
//               ),
//             ),
//             Button0(buttonText: "buttonText", function: saveSelectedData),
//           ],
//         ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
//
// class ChecklistPage extends StatefulWidget {
//   List<Data> checklistItems ; // List to store the checklist items
//   ChecklistPage({required this.checklistItems});
//
//   @override
//   _ChecklistPageState createState() => _ChecklistPageState();
// }
//
// class _ChecklistPageState extends State<ChecklistPage> {
//   List<String> selectedItems = []; // List to store the selected items
//
//   void toggleItemSelection(int index, bool value) {
//     setState(() {
//       final item = widget.checklistItems[index];
//       if (value) {
//         selectedItems.add(item);
//       } else {
//         selectedItems.remove(item);
//       }
//     });
//   }
//
//   void saveSelectedData() {
//     // Perform actions to save the selected data
//     print('Selected Items: $selectedItems');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 70.w,
//       child: Column(
//         children: [
//           Container(
//             // height: 30.h,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: widget.checklistItems.length,
//               itemBuilder: (context, index) {
//                 final item = widget.checklistItems[index];
//
//                 return CheckboxListTile(
//                   title: Text(item, style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
//                   value: selectedItems.contains(item),
//                   onChanged: (value) {
//                     toggleItemSelection(index, value!);
//                   },
//                 );
//               },
//             ),
//           ),
//           // Button0(buttonText: "buttonText", function: saveSelectedData),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../features/list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
//
//
// class AdditionalOptionsChecklist extends StatelessWidget {
//   final String itemId;
//
//   AdditionalOptionsChecklist({required this.itemId});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AdditionalOptionsCubit, AdditionalOptionsState>(
//       builder: (context, state) {
//         if (state is AdditionalOptionsInitial) {
//           // Fetch additional options when the widget is first built
//           BlocProvider.of<AdditionalOptionsCubit>(context)
//               .getAdditionalOptions(itemId);
//           return CircularProgressIndicator();
//         } else if (state is AdditionalOptionsLoaded) {
//           final options =
//               BlocProvider.of<AdditionalOptionsCubit>(context).options;
//
//           if (options != null) {
//             return ListView.builder(
//               itemCount: options.length,
//               itemBuilder: (context, index) {
//                 final option = options[index];
//                 return CheckboxListTile(
//                   title: Text(option.name.toString() + option.price.toString()),
//                   value: option.s,
//                   onChanged: (value) {
//                     // Update the selected value of the option
//                     // BlocProvider.of<AdditionalOptionsCubit>(context)
//                     //     .updateOptionSelectedStatus(option.id, value ?? false);
//                   },
//                 );
//               },
//             );
//           } else {
//             return Text('No options available.');
//           }
//         } else if (state is AdditionalOptionsFailed) {
//           return Text('Failed to load additional options.');
//         }
//
//         return Container();
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../features/list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
import '../features/list_of_category_details/data_layer/additional_options_model.dart';

List<String> selectedItems = [];


class ChecklistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AdditionalOptionsCubit, AdditionalOptionsState>(
      builder: (context, state) {
        final addOp = AdditionalOptionsCubit.get(context);
        if (state is AdditionalOptionsLoaded) {
          // final checklistItems = addOp.options;

          return _ChecklistContent(checklistItems: addOp.options);
        }

        return Container(); // Return an empty container or show a loading indicator if needed
      },
    );
  }
}

class _ChecklistContent extends StatefulWidget {
  final List<Data> checklistItems;

  _ChecklistContent({required this.checklistItems});

  @override
  _ChecklistContentState createState() => _ChecklistContentState();
}

class _ChecklistContentState extends State<_ChecklistContent> {

  void toggleItemSelection(int index, bool value) {
    setState(() {
      final item = widget.checklistItems[index];
      if (value) {
        selectedItems.add(item.name.toString()); // Assuming 'title' is the item property to display as checklist item
      } else {
        selectedItems.remove(item.name.toString());
      }
    });
  }

  void saveSelectedData() {
    // Perform actions to save the selected data
    print('Selected Items: $selectedItems');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      child: Column(
        children: [
          Container(
            color: Colors.red,
            width: 100,
            height: 50,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.checklistItems.length,
              itemBuilder: (context, index) {
                final item = widget.checklistItems[index];

                return CheckboxListTile(
                  title: Text(
                    item.name.toString(),
                    style: TextStyle(
                      color: Colors.indigo,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  value: selectedItems.contains(item.name.toString()),
                  onChanged: (value) {
                    toggleItemSelection(index, value!);
                  },
                );
              },
            ),
          ),
          // Button0(buttonText: "buttonText", function: saveSelectedData),
        ],
      ),
    );
  }
}