
import 'dart:async';

import 'package:barter_it/layout/home_layout/home_screen.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/onboarding/onboarding_screen.dart';
import 'package:barter_it/screens/select_sign_way/sign_ways_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  bool isLogin= Shared.getBool(key: 'isLogin') ==null ? false :Shared.getBool(key: 'isLogin');
  bool onBoarding= Shared.getBool(key: 'onBoarding') ==null ? false :Shared.getBool(key: 'onBoarding');
  Timer ? timer;

  @override
  void initState() {
    timer=Timer(const Duration(seconds: 3), (){

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => onBoarding? (isLogin? HomeScreen(): SelectSignWay())
          :const OnBoardingScreen(),),
          (route) => false
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body:const Center(
        child: SpinKitCircle(
          color: AppColors.buttonColor,
          size: 100,
          duration: Duration(seconds: 1),
        ) ,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }
}
