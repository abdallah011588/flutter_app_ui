
import 'dart:async';
import 'package:barter_it/layout/home_layout/home_screen.dart';
import 'package:barter_it/screens/onboarding/onboarding_screen.dart';
import 'package:barter_it/screens/select_sign_way/sign_ways_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  bool isLogin= Shared.getBool(key: 'isLogin') ==null ? false :Shared.getBool(key: 'isLogin');
  bool onBoarding= Shared.getBool(key: 'onBoarding') ==null ? false :Shared.getBool(key: 'onBoarding');
  Timer ? timer;

  late AnimationController _controller;
  // animation
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    timer = Timer( const Duration(seconds: 4), (){
      Navigator.pushAndRemoveUntil( context,
          MaterialPageRoute(
            builder: (context) => onBoarding? (isLogin? HomeScreen(): SelectSignWay()) :const OnBoardingScreen(),
          ),
          (route) => false
      );
    });
    _controller = AnimationController(duration: const Duration(milliseconds: 3700), vsync: this)..repeat(reverse: true,);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

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
      body: Center(
        child: FadeTransition(opacity: _animation,child: Image.asset("assets/images/splash_icon.png",),) ,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    timer!.cancel();
    super.dispose();

  }
}
