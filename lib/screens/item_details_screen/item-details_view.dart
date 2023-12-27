
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/product_model.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/show_chat/show_chat_screen.dart';
import 'package:barter_it/screens/show_image_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ItemDetailsScreen extends StatelessWidget {
   ItemDetailsScreen({Key? key,required this.productModel}) : super(key: key);
   final PageController pageController = PageController();
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel!.name!),
        backgroundColor:AppColors.white,
        toolbarHeight: 80,
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
        actions: [
         if(productModel!.owner!.uId==AppCubit.get(context).userData!.uId) Padding(
           padding: const EdgeInsets.all(20.0),
           child: DropdownButton<String>(
             focusColor: AppColors.white,
              items: [
              DropdownMenuItem(
                child:Text(translate(context,"Edit")!),
                value: "Edit",
                onTap: (){
                },
              ),
              DropdownMenuItem(
                child:Text(translate(context,"Delete")!),
                value: "Delete",
                onTap: (){
                  AppCubit.get(context).deleteMyProduct(productModel!.category!, productModel!.id!, productModel!.images!, context);
                  },
              ),
            ],
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(Icons.more_vert,color: AppColors.black,size: 30,),
              ),
              underline: SizedBox.shrink(),
              onChanged: (value){},
            ),
         ),
        ],
      ),
      bottomNavigationBar:productModel!.owner!.email != AppCubit.get(context).userData!.email?
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 40,
          width: double.infinity,
          child: ClipRRect(
            borderRadius:BorderRadius.circular(20) ,
            child: MaterialButton(
              color: AppColors.buttonColor,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowChatScreen(model: productModel!.owner!),));
              },
              child: Text(
                translate(context,'Chat Now')!,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
              ),
            ),
          ),
        ),
      )
      :SizedBox.shrink(),
      body: NotificationListener<OverscrollIndicatorNotification>(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowImageScreen(imageUrl: productModel!.images![index]),));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50) ),
                              child: Hero(
                                  tag: productModel!.images![0].toString() ,
                                  child: Image.network(productModel!.images![index],fit: BoxFit.cover,))
                          ),
                        );
                      },
                      itemCount: productModel!.images!.length,
                      scrollDirection: Axis.horizontal,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: productModel!.images!.length,
                        axisDirection: Axis.horizontal,
                        effect: ScrollingDotsEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          dotColor: Colors.grey[400]!,
                          activeDotColor: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  productModel!.name!,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  productModel!.price!,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: AppColors.primary),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.category,color: AppColors.buttonColor,),
                    SizedBox(width: 5,),
                    Text(
                      productModel!.category!,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(translate(context,'Description')!,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  productModel!.description!,
                  style: TextStyle(fontWeight:FontWeight.w300, fontSize: 20),
                ),
              ),
              Divider(color: Colors.grey[400],thickness: 5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(translate(context,'Posted at')!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on,size: 15,),
                    Expanded(
                      child: Text(
                        productModel!.owner!.location!.addressCity! + ","+  productModel!.owner!.location!.addressStreet!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng( productModel!.owner!.location!.addressLat!, productModel!.owner!.location!.addressLong!),
                    tilt: 59.440717697143555,
                    zoom: 10.151926040649414,
                    bearing: 192.8334901395799,
                  ),
                  onMapCreated: (mapController){
                    AppCubit.get(context).mapControllerCompleter= mapController;
                  },
                  markers: {
                    Marker(markerId: MarkerId("2"),position: LatLng( productModel!.owner!.location!.addressLat!, productModel!.owner!.location!.addressLong!)),
                  },
                  mapType: MapType.normal,
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(()=>EagerGestureRecognizer()),
                  },
                ),
              ),
              Divider(color: Colors.grey[400],thickness: 5),
              if(productModel!.owner!.email != AppCubit.get(context).userData!.email)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.buttonColor,
                        child: Text(
                          productModel!.owner!.name![0],
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: Text(
                          productModel!.owner!.name!,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: (){},
                        child: Text(translate(context, 'Follow')!,style: TextStyle(color: AppColors.buttonColor,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              if(productModel!.owner!.email != AppCubit.get(context).userData!.email)
                Divider(color: Colors.grey[400],thickness: 5),
            ],
          ),
        ),
        onNotification: (scroll){
          scroll.disallowIndicator();
          return true;
        },
      ),
    );
  }
}
