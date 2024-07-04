
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/features/list_of_category/business_layer/items_cubit.dart';
import 'package:Reservation/features/list_of_category/business_layer_free_times/free_times_cubit.dart';
import '../../../colors/app_colors.dart';
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
            child:const DrawerWidget(),
          ),

          appBar: AppBar(
            iconTheme:const IconThemeData(color: Colors.white),

            backgroundColor: AppColors.litePurple,
              title: Center(
                child: Text("المنشآت",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.sp)),
              ),
          ),

          body: (state is GetCategoriesLoading)
              ? const Center(child: CircularProgressIndicator(),)
              :  (state is GetCategoriesSuccess)?Padding(
                padding:const EdgeInsets.only( left: 20, right: 20, top: 20 ),
                child: GridView.builder(
                  shrinkWrap:true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 50.w, // Maximum width of each child
                  mainAxisSpacing: 10.0, // Vertical spacing between children
                  crossAxisSpacing: 10.0, // Horizontal spacing between children
                  childAspectRatio: 0.75,
                ),
                itemCount: categoryCubit.categories.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100.h,
                    child: Column(
                      children: [
                        InkWell(
                                    onTap: () {
                                      print(categoryCubit.categories[index].id!);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider<ItemsCubit>(
                                              create: (context) => ItemsCubit()..getCategoryItems(categoryCubit.categories[index].name!),                                      ),
                                            BlocProvider<FreeTimesCubit>(
                                              create: (context) => FreeTimesCubit(),
                                            ),
                                          ],
                                          child: const ListOfCategoryScreen())));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.circular(15.sp),
                                        // border: Border.all(
                                        //   color: AppColors.litePurple,
                                        //   width: 3,
                                        // ),
                                        boxShadow:const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 0.2,
                                            blurRadius: 0.5,
                                          ),
                                        ],
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        categoryCubit.categories[index].image!,
                                        imageBuilder: (context, imageProvider) =>
                                            Container(
                                              width: 100.w,
                                              height: 20.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.sp),
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
                                    ),
                                  ),
                        const SizedBox(height: 10,),
                        Text(
                          categoryCubit.categories[index].name!,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.litePurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 19.sp,
                          ),
                        ),
                        const SizedBox(height: 10,),

                      ],
                    ),
                  );
                          },
                        ),
                      ): Container(),          // Padding(

        );
      },
    );
  }
}