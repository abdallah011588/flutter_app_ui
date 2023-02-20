import 'package:barter_it/components/components.dart';
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/layout/home_layout/home_screen.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/password_reset/password_reset_view.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

var formKey = GlobalKey<FormState>();
var emailController=TextEditingController();
var passwordController=TextEditingController();

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context, state) {
       if(state is LoginSuccessState)
       {
         emailController.clear();
         passwordController.clear();
         print('login view *********************************');
         UID=state.uId;
         Shared.setData( key: 'uId', value: state.uId ).then((value) {
           AppCubit.get(context).getUserData();
           //AppCubit.get(context).getAllUsers();
           Shared.setData(key: 'isLogin', value: true).then((value) {
             Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,
             );
           });
           //   emailController.clear();
           //  passwordController.clear();
           //   emailController.dispose();
           //  passwordController.dispose();
           print(state.uId +'in login state.uid tap');
           Fluttertoast.showToast(
             msg: 'Sign_success',
             gravity: ToastGravity.BOTTOM,
             backgroundColor: Colors.green,
             textColor: Colors.white,
             timeInSecForIosWeb: 5,
             toastLength: Toast.LENGTH_LONG,
           );

         }).catchError((error){
           print(error.toString());
         });
       }
       if( state is LoginErrorState)
       {
         Fluttertoast.showToast(
           msg:
           state.error.toString().contains('[firebase_auth/email-already-in-use]')?
           state.error.toString().replaceAll('[firebase_auth/email-already-in-use]', '')
               :state.error.toString().contains('[firebase_auth/invalid-email]')?
           state.error.toString().replaceAll('[firebase_auth/invalid-email]', ''):
           state.error.toString().contains('[firebase_auth/wrong-password]')?
           state.error.toString().replaceAll('[firebase_auth/wrong-password]', ''):
           state.error.toString().contains('[firebase_auth/too-many-requests]')?
           state.error.toString().replaceAll('[firebase_auth/too-many-requests]', '')
               :state.error.toString().replaceAll('[firebase_auth/user-not-found]', '')
           ,
           gravity: ToastGravity.BOTTOM,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           timeInSecForIosWeb: 5,
           toastLength: Toast.LENGTH_LONG,
         );
         print(state.error);
       }
     },
     builder: (context, state) {
     return Padding(
       padding: MediaQuery.of(context).viewInsets,
       child: Container(
         //  height: 300,
         color: Colors.white,
         child: Padding(
           padding: const EdgeInsets.only(top: 20.0),
           child: Form(
             key: formKey,
             child: SingleChildScrollView(
              child:Padding(
               padding:const EdgeInsets.all(20.0),
               child:Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                 /// EMAIL TEXT_FORM_FIELD
                  Container(
                    decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(15),
                         boxShadow:const [
                           BoxShadow(color: Colors.grey,blurRadius: 15),
                         ],
                       ),
                       child: TextFormField(
                         decoration: InputDecoration(
                           labelText: 'Email',
                           labelStyle:const TextStyle(height: 5),
                           prefixIcon:const Icon(Icons.email),
                           focusColor: Colors.white,
                           enabledBorder: mainBorder,
                           disabledBorder: mainBorder,
                           focusedBorder: mainBorder,
                           errorBorder: mainBorder,
                           focusedErrorBorder:mainBorder,
                         ),
                         keyboardType: TextInputType.emailAddress,
                         controller: emailController,
                         validator: (value){
                           if(value!.isEmpty)
                           {
                             return "Email can't be empty!";
                           }
                           else if(!emailController.text.contains('@gmail'))
                           {
                             return "Email format is not correct !";
                           }
                           return null;
                         },
                       ),
                     ),
                 const SizedBox(
                       height: 30,
                     ),
                 /// PASSWORD TEXT_FORM_FIELD
                 Container(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(15),
                     boxShadow:const [
                       BoxShadow(color: Colors.grey,blurRadius: 15),
                     ],
                   ),
                   child: TextFormField(
                     decoration: InputDecoration(
                       labelText: 'Password',
                       labelStyle:const TextStyle(height: 5),
                       prefixIcon:const Icon(Icons.lock),
                       suffixIcon: IconButton(
                         onPressed: (){
                           AppCubit.get(context).showPassword();
                         },
                         icon: Icon(AppCubit.get(context).visibilityIcon),
                       ),
                       focusColor: Colors.white,
                       enabledBorder: mainBorder,
                       disabledBorder: mainBorder,
                       focusedBorder: mainBorder,
                       errorBorder: mainBorder,
                       focusedErrorBorder:mainBorder,
                     ),
                     obscureText: AppCubit.get(context).IsPass,
                     keyboardType: TextInputType.visiblePassword,
                     controller: passwordController,
                     validator: (value){
                       if(value!.isEmpty)
                       {
                         return "Password can't be empty!";
                       }
                       return null;
                     },
                   ),
                     ),
                 /// FORGOT PASSWORD TEXT_BUTTON
                 Align(
                       alignment: Alignment.centerRight,
                       child: TextButton(
                         onPressed: (){
                           /// FORGOT PASSWORD VIEW
                           showModalBottomSheet(
                             isScrollControlled: true,
                             context: context,
                             builder: (context)=> const PasswordResetView(),
                           );
                         },
                         child:const Text('Forgot password?'),
                       ),
                     ),
                 /// MAIN LOGIN BUTTON **********************
                 state is !LoginLoadingState? Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Container(
                     decoration: BoxDecoration(
                       color: AppColors.buttonColor,
                       borderRadius: BorderRadius.circular(20),
                     ),
                     height: 50,
                     width: 120,
                     child: ClipRRect(
                       borderRadius:BorderRadius.circular(20) ,
                       child: MaterialButton(
                         color: AppColors.buttonColor,
                         onPressed: (){
                           if(formKey.currentState!.validate())
                           {
                             AppCubit.get(context).userLogin(
                               email: emailController.text,
                               password: passwordController.text,
                             );
                           }
                         },
                         child:const Text(
                           'LOGIN',
                           style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
                         ),
                       ),
                     ),
                   ),
                  )
                 :const Center(
                   child: SpinKitChasingDots(
                     color: AppColors.buttonColor,
                     size: 50,
                     duration: Duration(seconds:1),
                   ) ,
                  ),
                 ],
                 ),
               ),
             ),
           ),
         ),
       ),
      );
      },
    );
  }
}


/// ////////////
/*Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                     height: 300,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: SingleChildScrollView(
                                        child: Form(
                                          // key: formKey,
                                          child: Column(
                                            //mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Padding(
                                                padding:  EdgeInsets.all(0.0),
                                                child: Text('Please enter your email to get the reset password link',
                                                  style: TextStyle(fontSize:20,fontWeight: FontWeight.w300,color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              /// FORGOT PASSWORD EMAIL TEXT-FORM_FIELD
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  boxShadow:const [
                                                    BoxShadow(color: Colors.grey,blurRadius: 15),
                                                  ],
                                                ),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    labelStyle:const TextStyle(height: 5),
                                                    prefixIcon:const Icon(Icons.email_outlined,color: AppColors.buttonColor,),
                                                    focusColor: Colors.white,
                                                    enabledBorder: mainBorder,
                                                    disabledBorder: mainBorder,
                                                    focusedBorder: mainBorder,
                                                    errorBorder: mainBorder,
                                                    focusedErrorBorder:mainBorder,
                                                  ),
                                                  keyboardType: TextInputType.emailAddress,
                                                  validator: (value){
                                                    if(value!.isEmpty)
                                                    {
                                                      return "Email can't be empty!";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),

                                              const SizedBox(height: 20,),

                                              /// RESET PASSWORD BUTTON
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.buttonColor,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  height: 50,
                                                  width: 140,
                                                  child: ClipRRect(
                                                    borderRadius:BorderRadius.circular(20) ,
                                                    child: MaterialButton(
                                                      color: AppColors.buttonColor,
                                                      onPressed: (){
                                                        // if(formKey.currentState!.validate())
                                                        // {
                                                        //   print('reset pass');
                                                        // }
                                                      },
                                                      child:const Text(
                                                        'Reset Password',
                                                        style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ) */
/// ////////////
/*

class LoginView {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  Widget loginView(context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  /// EMAIL TEXT_FORM_FIELD
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 15),
                      ],
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(height: 5),
                        prefixIcon: const Icon(Icons.email),
                        focusColor: Colors.white,
                        enabledBorder: mainBorder,
                        disabledBorder: mainBorder,
                        focusedBorder: mainBorder,
                        errorBorder: mainBorder,
                        focusedErrorBorder: mainBorder,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email can't be empty!";
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  /// PASSWORD TEXT_FORM_FIELD
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 15),
                      ],
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(height: 5),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            AppCubit.get(context).showPassword();
                          },
                          icon: Icon(AppCubit.get(context).visibilityIcon),
                        ),
                        focusColor: Colors.white,
                        enabledBorder: mainBorder,
                        disabledBorder: mainBorder,
                        focusedBorder: mainBorder,
                        errorBorder: mainBorder,
                        focusedErrorBorder: mainBorder,
                      ),
                      obscureText: AppCubit.get(context).IsPass,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can't be empty!";
                        }
                        return null;
                      },
                    ),
                  ),

                  /// FORGOT PASSWORD TEXT_BUTTON
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        /// FORGOT PASSWORD VIEW
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 400,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Form(
                                // key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Text(
                                        'Please enter your email to get the reset password link',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    /// FORGOT PASSWORD EMAIL TEXT-FORM_FIELD
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 15),
                                        ],
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle:
                                              const TextStyle(height: 5),
                                          prefixIcon: const Icon(
                                            Icons.email_outlined,
                                            color: AppColors.buttonColor,
                                          ),
                                          focusColor: Colors.white,
                                          enabledBorder: mainBorder,
                                          disabledBorder: mainBorder,
                                          focusedBorder: mainBorder,
                                          errorBorder: mainBorder,
                                          focusedErrorBorder: mainBorder,
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Email can't be empty!";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    /// RESET PASSWORD BUTTON
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 50,
                                        width: 140,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: MaterialButton(
                                            color: AppColors.buttonColor,
                                            onPressed: () {
                                              // if(formKey.currentState!.validate())
                                              // {
                                              //   print('reset pass');
                                              // }
                                            },
                                            child: const Text(
                                              'Reset Password',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ),

                  /// MAIN LOGIN BUTTON **********************
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      //clipBehavior:Clip.antiAlias ,
                      height: 50,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: MaterialButton(
                          color: AppColors.buttonColor,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => true,
                              );
                            }
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

*/
