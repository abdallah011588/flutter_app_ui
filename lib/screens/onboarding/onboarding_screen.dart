
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/screens/select_sign_way/sign_ways_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  late PageController pageController;
  int pageIndex=0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

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
                pageIndex<2? TextButton(
                   onPressed: (){
                     setState(() {
                       pageIndex=2;
                       pageController.jumpToPage(2);
                     });
                   },
                   child: Text('Skip',
                     style:const TextStyle(color: Color(0xFFff9800)),
                   ),
               )
                    :SizedBox(width: 60,),
                SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        dotWidth: 9,
                        dotHeight: 9,
                        dotColor: Colors.grey[400]!,
                        activeDotColor: Colors.blue,
                    ),
                ),
                IconButton(
                    onPressed: (){
                      if(pageIndex<2)
                        {
                          setState(() {
                            pageIndex+=1;
                            pageController.nextPage(duration:const Duration(milliseconds: 500), curve: Curves.easeInToLinear);
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
                      pageIndex<2? Icons.navigate_next:Icons.check,
                      color:const Color(0xFFff9800),
                       size: 30,
                  ),

                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}


Widget onBoardingBuilder(pageController ,String image ,String title,String subTitle)
{
  
  return Column(
    children: [
      Expanded(child:  Lottie.asset(image),),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(title,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
      ),
      Padding(
       padding: const EdgeInsets.all(20.0),
       child: Text( subTitle ,style:const  TextStyle(color :Colors.black54, fontSize: 16),textAlign: TextAlign.center),
      ),
    ],
  );
}
