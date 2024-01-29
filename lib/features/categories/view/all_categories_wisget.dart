
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:Reservation/features/list_of_category/business_layer/items_cubit.dart';
import 'package:Reservation/features/list_of_category/business_layer_free_times/free_times_cubit.dart';
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

            backgroundColor: Colors.deepOrange,
              title:const Center(
                child: Text("المنشآت",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
          ),
          body: (state is GetCategoriesLoading)
              ? const Center(child: CircularProgressIndicator(),)
              :  (state is GetCategoriesSuccess)?Padding(
                padding:const EdgeInsets.only( left: 20, right: 20, top: 20 ),

                child: GridView.builder(
                  shrinkWrap:true,
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
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.deepOrangeAccent,
                                    width: 3,
                                  ),
                                  boxShadow:const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                        categoryCubit.categories[index].image!,
                                        imageBuilder: (context, imageProvider) =>
                                            Container(
                                              width: 100.w,
                                              height: 18.h,

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
                                      SizedBox(height: 2.h),
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
                      ): Container(),          // Padding(

        );
      },
    );
  }
}