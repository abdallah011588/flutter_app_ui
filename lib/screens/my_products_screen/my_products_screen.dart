import 'package:barter_it/components/components.dart';
import 'package:barter_it/components/widgets/item_builder.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/product_model.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/add_item_screen/add_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({Key? key, required this.products }) : super(key: key);
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) =>{},
      builder: (context, state) => Scaffold(
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
               onTap: (){
                 showSearch(context: context, delegate: SearchView(searchProducts: products));
               },
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
                     Text(translate(context,'Search on your products')!,
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
           bottom: PreferredSize(
               child: Align(
                 alignment: Alignment.centerLeft,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                   child: Text(translate(context,"My Products" )!,
                     style: TextStyle(fontSize: 25,),
                     textAlign: TextAlign.start,
                   ),
                 ),
               ),
               preferredSize: Size(100, 35),
           ),
         ),
       body: products.isNotEmpty?
        GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 3/4,
        ),
        itemBuilder:(context , index)=>
        products.isEmpty?
        CircularProgressIndicator(): ItemBuilder(context: context,product: products[index]) ,
        itemCount: products.length,
      ) :Center(child: Text(translate(context,"No Products")!,style: TextStyle(fontSize: 20),),),
    ), );
  }
}
