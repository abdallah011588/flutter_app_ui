
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/login/login_view.dart';
import 'package:barter_it/screens/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SelectSignWay extends StatelessWidget {
  SelectSignWay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Lottie.asset("assets/images/4.json"),
            ),
            Column(
              children:  [
                Padding(
                  padding:const EdgeInsets.all(10.0),
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(text:translate(context, 'Welcome to ')!,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500)),
                        TextSpan(text: 'BarterIt ',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: AppColors.buttonColor)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Text(
                    translate(context,'Exchange made easy!')!,
                    style: TextStyle(fontSize: 21,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height/10,
            ),

            Column(
              children: [
                /// SIGN UP BUTTON **************************************
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 50,
                    width: 300,
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(20) ,
                      child: MaterialButton(
                        color: AppColors.buttonColor,
                        child: Text(translate(context, 'SIGN UP')!,
                          style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
                        ),
                        onPressed: (){
                          /// SIGN UP FORM
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return const RegisterView();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),

                /// LOGIN TEXT_BUTTON **************************************
                Padding(
                  padding: const EdgeInsets.all( 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          translate(context,'Already have an account?')!,
                          style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),
                        ),
                      ),
                      /// LOGIN TEXT_BUTTON
                      TextButton(
                        child: Text(
                        translate(context,'Login')!,
                          style:const TextStyle(
                            fontSize: 20,
                            color: Color(0xFFff9800),
                          ),
                        ),

                        onPressed: (){
                          /// LOGIN FORM ********
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const LoginView();
                            },

                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height/10,
            ),
          ],
        ),
      ),
    );
  }
}
