
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/features/list_of_category/business_layer/items_cubit.dart';
import '../../drawer/drawe_widget.dart';
import '../../list_of_category/view/list_of_category_screen.dart';
import '../business_layer/categories_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ViewCategoriesScreen extends StatelessWidget {
  const ViewCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var categoryCubit = CategoryCubit.get(context);

    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          drawer: BlocProvider(
            create: (context) => CategoryCubit()..getCategories(),
            child: DrawerWidget(),
          ),

          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
              title: Center(
                child: const Text("المنشآت",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
          ),
          body: (state is GetCategoriesLoading)
              ? const Center(child: CircularProgressIndicator(),)
              :  (state is GetCategoriesSuccess)?Expanded(
            child: Padding(
              padding: EdgeInsets.only( left: 20, right: 20, top: 20 ),

              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.w,
                mainAxisSpacing: 2.h,
              ),
              itemCount: categoryCubit.categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                            onTap: () {
                              print(categoryCubit.categories[index].id!);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(
  create: (context) => ItemsCubit()..getCategoryItems(categoryCubit.categories[index].name!),
  child: ListOfCategoryScreen(),
)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.sp),
                                color: Colors.black26,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 2.h),
                                    CachedNetworkImage(
                                      imageUrl:
                                      categoryCubit.categories[index].image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            width: 140,
                                            height: 15.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.sp),
                                              image: DecorationImage(

                                                image: imageProvider,
                                                fit: BoxFit.fill,

                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                    // SizedBox(height: 2.h),
                                    Text(
                                      categoryCubit.categories[index].name!,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
          ): Container(),          // Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: GridView.builder(
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio: 1.5,
          //       crossAxisSpacing: 25.w,
          //       mainAxisSpacing: 8.h,
          //     ),
          //     itemCount: categoryCubit.categories.length,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //         onTap: () {
          //           // context.pushNamed(Routes.viewCategoryDetailsScreen,
          //           //     arguments: categoryCubit.categories[index].name!);
          //         },
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20.r),
          //             color: Colors.blueGrey,
          //           ),
          //           child: Center(
          //             child: Column(
          //               children: [
          //                 SizedBox(height: 10.h),
          //                 CachedNetworkImage(
          //                   imageUrl:
          //                   categoryCubit.categories[index].image!,
          //                   imageBuilder: (context, imageProvider) =>
          //                       Container(
          //                         width: 140,
          //                         height: 108,
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(20.r),
          //                           image: DecorationImage(
          //                             image: imageProvider,
          //                             fit: BoxFit.contain,
          //                           ),
          //                         ),
          //                       ),
          //                   placeholder: (context, url) =>
          //                   const CircularProgressIndicator(),
          //                   errorWidget: (context, url, error) =>
          //                   const Icon(Icons.error),
          //                 ),
          //                 SizedBox(height: 2.h),
          //                 Padding(
          //                   padding:
          //                   EdgeInsets.symmetric(horizontal: 10.w),
          //                   child: Text(
          //                     categoryCubit.categories[index].name!,
          //                     style: TextStyle(
          //                       overflow: TextOverflow.ellipsis,
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 19.sp,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        );
      },
    );
  }
}