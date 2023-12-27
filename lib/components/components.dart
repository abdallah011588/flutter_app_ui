
import 'dart:io';
import 'package:barter_it/components/widgets/item_builder.dart';
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/product_model.dart';
import 'package:barter_it/screens/select_sign_way/sign_ways_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

InputBorder mainBorder= OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
);

InputBorder editBorder= OutlineInputBorder(
  borderRadius: BorderRadius.circular(25),
  borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
);

Widget buildListTile(String title, IconData icon, String trailing, Color color, {onTab}) {
  return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withAlpha(30)
        ),
        child: Center(
          child: Icon(icon, color: color,),
        ),
      ),
      title: Text(title, style: const TextStyle(color: Colors.black,fontSize: 17)),
      trailing: SizedBox(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(trailing, style:  TextStyle(color: Colors.grey,fontSize: 17)),
            const Icon(Icons.arrow_forward_ios, size: 16,),
          ],
        ),
      ),
      onTap: onTab
  );
}

class SearchView extends SearchDelegate{

   SearchView({required this.searchProducts});
  final List<ProductModel> searchProducts;

   List<ProductModel> products =[];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query="";
      }, icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, "");
    }, icon: Icon(Icons.arrow_back));
  }


  @override
  Widget buildResults(BuildContext context) {
    products = query.isEmpty? [] : searchProducts.where((element) {
      return  element.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return  products.isNotEmpty? Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 3/4,
        ),
        itemBuilder:(context , index)=> products.isEmpty?
        // AppCubit.get(context).allProducts.isEmpty?
        CircularProgressIndicator(): ItemBuilder(context: context,product: products[index]) ,
        itemCount: products.length,
      ),
    ):
     Center(child: Text(translate(context,"No Products")!,style: Theme.of(context).textTheme.subtitle1,),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    products = query.isEmpty? [] : searchProducts.where((element) {
      return  element.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return products.isNotEmpty? Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 3/4,
        ),
        itemBuilder:(context , index)=>
        products.isEmpty?
        // AppCubit.get(context).allProducts.isEmpty?
        CircularProgressIndicator(): ItemBuilder(context:context,product: products[index]) ,
        itemCount: products.length,
      ),
    ):
     Center(child: Text(translate(context,"No Products")!,style: Theme.of(context).textTheme.subtitle1,),);
  }


   @override
   ThemeData appBarTheme(BuildContext context) {
     return Theme.of(context).copyWith(
       scaffoldBackgroundColor: Colors.white,

       inputDecorationTheme: const InputDecorationTheme(
         hintStyle: TextStyle(
           fontWeight: FontWeight.normal,
           color:Colors.black,
         ),
         border: UnderlineInputBorder(),
       ),
       textTheme:  TextTheme(
           subtitle1: TextStyle(
             color:Colors.black,
             fontSize: 17,
             fontFamily: "Cairo"
           ),
           subtitle2: TextStyle(
             color:Colors.black,
             fontSize: 20,
               fontFamily: "Cairo"

           ),

       ),
     );
   }

}

class AppDio
{
  static late Dio dio;
  static void init()async
  {
    dio = await Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
        receiveDataWhenStatusError: true,
        // connectTimeout: 10000,
        // receiveTimeout: 10000,
      ),
    );
  }


  static Future<Response> postData ({
    required Map<String,dynamic>? data,
    Map<String,dynamic>? query,
  }) async{
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "key="
    };

    return await dio.post(
      'send',
      queryParameters: query,
      data: data,
    );
  }

}

String handleError(error)
{
  return "${
      error.contains('[firebase_auth/email-already-in-use]')?
      error.replaceAll('[firebase_auth/email-already-in-use]', '')
          :error.contains('[firebase_auth/invalid-email]')?
      error.replaceAll('[firebase_auth/invalid-email]', ''):
      error.contains('[firebase_auth/wrong-password]')?
      error.replaceAll('[firebase_auth/wrong-password]', ''):
      error.contains('[firebase_auth/too-many-requests]')?
      error.replaceAll('[firebase_auth/too-many-requests]', '')
          :error.contains('[firebase_auth/user-not-found]',)?
      error.replaceAll('[firebase_auth/user-not-found]', '')
          :error.contains('[firebase_auth/network-request-failed]', )?
      error.replaceAll('[firebase_auth/network-request-failed]', '')
          : 'Something went wrong'
  }";
}


String handleRegisterError(error)
{
  return '${
      error.contains('[firebase_auth/email-already-in-use]')?
      error.replaceAll('[firebase_auth/email-already-in-use]', '')
          :error.contains('[firebase_auth/invalid-email]')?
      error.replaceAll('[firebase_auth/invalid-email]', '')
          : error.contains('[firebase_auth/weak-password]', )?
      error.replaceAll('[firebase_auth/weak-password]', '')
          : error.contains('[firebase_auth/network-request-failed]', )?
      error.replaceAll('[firebase_auth/network-request-failed]','' )
          : 'Something went wrong'
  }';
}

alertToExit(context)
{
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title:  Text(translate(context,'Alert')!,style: TextStyle(color: Colors.orange,fontSize: 18,fontWeight: FontWeight.bold),),
      content: Text(translate(context,'Do you want to exit the app ?')!),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context,'Cancel'),
          child: Text(translate(context,'Cancel')!,style: TextStyle(color: Colors.blue),),
        ),
        TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(translate(context,'OK')!,style: TextStyle(color: Colors.red),),
        ),
      ],
    ),
  );
}

alertToLogOut(context)
{
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title:  Text(translate(context,'Log Out')!,style: TextStyle(color: Colors.orange),),
      content: Text(translate(context,'Do you want to log out')!),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context,'Cancel'),
          child: Text(translate(context,'Cancel')!,style: TextStyle(color: Colors.blue),),
        ),
        TextButton(
          onPressed: () {
            Shared.setData(key: 'isLogin', value: false).then((value) {
              FirebaseMessaging.instance.unsubscribeFromTopic("users${Shared.getString(key: 'uId')}");
              print("log out*****"+Shared.getString(key: 'uId')!);
              Shared.removeData(key: 'uId',).then((value) {
                AppCubit.get(context).userData =null;
                UID='';
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SelectSignWay()), (route) => false,
                );
              });
            });
          },
          child: Text(translate(context,'OK')!,style: TextStyle(color: Colors.red),),
        ),
      ],
    ),
  );
}

showFlutterToast(String message)
{
  Fluttertoast.showToast(
    msg:message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    timeInSecForIosWeb: 5,
    toastLength: Toast.LENGTH_LONG,
  );
}
