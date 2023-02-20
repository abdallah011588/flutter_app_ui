
import 'package:barter_it/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ItemDetailsScreen extends StatelessWidget {

   ItemDetailsScreen({Key? key}) : super(key: key);
   var pageController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('item Name'),
        foregroundColor: Colors.white,
        backgroundColor:AppColors.buttonColor,
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: AppColors.buttonColor,
         statusBarIconBrightness: Brightness.light,
           statusBarBrightness: Brightness.light,
       ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 500,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          controller: pageController,
                          itemBuilder: (context, index) {
                          return Image.asset('assets/images/item.jpg',fit: BoxFit.cover,);
                        },
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: 3,
                            axisDirection: Axis.horizontal,
                            effect: ScrollingDotsEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                            '\$900000',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        'Name',
                      style: TextStyle(fontSize: 20),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      borderRadius:BorderRadius.circular(25),
                      onTap: (){
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.category,color: AppColors.buttonColor,),
                              SizedBox(width: 5,),
                              Text(
                                'Category name',
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
                            'Egypt ,cairo,street 12',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Description',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        'car car car car car car car car',
                      style: TextStyle(fontWeight:FontWeight.w300, fontSize: 20),

                    ),
                  ),
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Posted at',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("ffffffffffffffffffffffffffff ffffffffffffff fffffffffff ffffffffffff "
                        "fffffffffffffffffffffffffffffffff"
                        "ffffffffffffffffffffffffffffffff"
                        "ffffffffffffffffffffffffffffffffff"
                        "ffffffffffffffffffffffffff"
                        "ffffffffffffffffffffffffffff"
                        "ffffffffffffffffffffffffff"
                        "ffffffffffffffffffffff",
                    ),
                  ),
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.buttonColor,
                          child: Text('A',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Text(
                            'User name',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: (){},
                          child: Text('Follow',style: TextStyle(color: AppColors.buttonColor,fontWeight: FontWeight.bold),
                        ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),


                ],
              ),
            ),
          ),
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
                  onPressed: (){},
                  child:const Text(
                    'Chat Now',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
