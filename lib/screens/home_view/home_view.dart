
import 'package:barter_it/components/components.dart';
import 'package:barter_it/components/widgets/category_item_builder.dart';
import 'package:barter_it/components/widgets/item_builder.dart';
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/categories_screen/categories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context, state) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: NotificationListener<OverscrollIndicatorNotification>(
        child: ListView(
          children: [
            if(AppCubit.get(context).userData !=null)
             Text("${translate(context,"Welcome back")!} ,${AppCubit.get(context).userData!.name!.split(" ")[0]}",
              style:  TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  borderRadius:BorderRadius.circular(25),
                  onTap: (){
                    showSearch(context: context, delegate: SearchView(searchProducts: AppCubit.get(context).allProducts));
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children:  [
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child:  Icon(Icons.search),
                        ),
                        Text(translate(context,'Search on BarterIt')!,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                 Text(translate(context,'Categories')!,
                  style:  TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoriesScreen(),));
                  },
                  child:  Text(translate(context,'See All')!,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.buttonColor,
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 120,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    AppCubit.get(context).getSpecificProducts(myCategories[index], index.toString(), context);
                  },
                  child: CategoryBuilder(category:myCategories[index],categoryImage: categoryImage[index]),
                ),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 15,),
             Text(translate(context,"Recommended for you")!,
              style:  TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15,),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 3/4,
              ),
              itemBuilder:(context , index)=>
              AppCubit.get(context).allProducts.isEmpty?
              CircularProgressIndicator(): ItemBuilder(context:context,product: AppCubit.get(context).allProducts[index]) ,
              itemCount: AppCubit.get(context).allProducts.length,
            )
          ],
        ),
        onNotification: (scroll){
          scroll.disallowIndicator();
          return true;
        },
      ),
    ), listener: (context, state) {});
  }
}
