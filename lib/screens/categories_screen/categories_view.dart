
import 'package:barter_it/components/widgets/category_item_builder.dart';
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/add_item_screen/add_item_view.dart';
import 'package:flutter/material.dart';
class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.drawerColor,blurRadius: 10,),
              ],
            ),
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(0.0),
          child: InkWell(
            borderRadius:BorderRadius.circular(25),
            onTap: (){},
            child: Container(
              height: 40,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  Text(translate(context,'Search on BarterIt')!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              //height: 30,
              //width: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.drawerColor,blurRadius: 10),
                ],
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewItemView(),));
                },
                icon: Icon(Icons.add_box_rounded),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(translate(context,'Find items to barter')!,
              style: TextStyle(fontSize: 25,),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio:1,
                  ),
                  itemBuilder:(context , index)=> InkWell(
                      onTap: (){
                        AppCubit.get(context).getSpecificProducts(myCategories[index], index.toString(), context);
                        },
                      child: CategoryBuilder(category:myCategories[index],categoryImage: categoryImage[index])) ,
                     itemCount: myCategories.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
