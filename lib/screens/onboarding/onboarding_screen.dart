
import 'package:barter_it/screens/select_sign_way/sign_ways_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController pageController = PageController();
  int pageIndex=0;
  IconData iconData=Icons.check;
  List<String> images=[
    'assets/images/shop2.jpg',
    'assets/images/shop6.jpg',
    'assets/images/shop8.jpg',
  ];

  List<String> title=[
    'Flex with easy way of trade',
    'Trade at your own convenience',
    'Connect with barters like you',
  ];

  List<String> subTitle=[
    'BarterIt offers you an easy way to exchange your items',
    'You get to set your items of the trade,and exchange at your own convenience',
    'Join thousands of willing barters and start exchanging seamlessly',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return onBoardingBuilder(pageController, images[index],title[index],subTitle[index]);
              },
              controller:pageController ,
              itemCount: 3,
              physics:const BouncingScrollPhysics(),
              onPageChanged:(int index){
                setState(() {
                  pageIndex=index;
                });
              },

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               TextButton(
                   onPressed: (){
                     setState(() {
                       pageIndex=2;
                       pageController.jumpToPage(2);
                     });
                   },
                   child: Text(
                       pageIndex<2? 'Skip':'',
                     style:const TextStyle(color: Color(0xFFff9800)),
                   ),
               ),
                SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect:const ExpandingDotsEffect(
                        dotWidth: 9,
                        dotHeight: 9,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                    ),
                ),
                IconButton(
                    onPressed: (){
                      if(pageIndex<2)
                        {
                          setState(() {
                            pageIndex+=1;
                            pageController.nextPage(duration:const Duration(milliseconds: 200), curve: Curves.easeInToLinear);
                          });
                       }
                      else
                        {
                          Shared.setData(key: 'onBoarding', value: true).then((value)  {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectSignWay(),));
                          });
                        }
                      },
                  icon: Icon(
                      pageIndex<2? Icons.skip_next:iconData,
                      color:const Color(0xFFff9800),
                       size: 35,
                  ),

                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


Widget onBoardingBuilder(pageController ,String image ,String title,String subTitle)
{
  
  return Column(
   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image.asset(image)),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(title,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      Padding(
       padding: const EdgeInsets.all(20.0),
       child: Text( subTitle ,style: const TextStyle(fontSize: 18),textAlign: TextAlign.center),
      ),
    ],
  );
}
