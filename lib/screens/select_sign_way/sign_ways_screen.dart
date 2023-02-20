

import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/login/login_view.dart';
import 'package:barter_it/screens/register/register_view.dart';
import 'package:flutter/material.dart';

class SelectSignWay extends StatelessWidget {
  SelectSignWay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/shop2.jpg'),

            Column(
              children:const [
                Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Welcome to ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500)),
                        TextSpan(text: 'BarterIt ',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: AppColors.buttonColor)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Text(
                    'Exchange made easy!',
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
                        child:const Text(
                          'SIGN UP',
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
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
                      const Padding(
                        padding:  EdgeInsets.all(10.0),
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,),
                        ),
                      ),
                      /// LOGIN TEXT_BUTTON
                      TextButton(
                        child:const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
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

/// ////////////
/*
   Widget loginView(context)
   {
     return Container(
       height: 300,
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
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                         ),
                         disabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.red,style: BorderStyle.solid,width: 1),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                         ),
                         errorBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                         ),
                         focusedErrorBorder:OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                         ),
                       ),
                       validator: (value){
                         if(value!.isEmpty)
                         {
                           return "Email can't be empty!";
                         }
                         return null;
                       },
                       keyboardType: TextInputType.emailAddress,
                     ),
                   ),
                   const SizedBox(height: 30,),
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

                           },
                           icon:const Icon(Icons.visibility),
                         ),
                         focusColor: Colors.white,
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),

                         ),
                         disabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.red,style: BorderStyle.solid,width: 1),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                         ),
                         errorBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                         ),
                         focusedErrorBorder:OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                         ),

                       ),
                       validator: (value){
                         if(value!.isEmpty)
                         {
                           return "Password can't be empty!";
                         }
                         return null;
                       },
                       obscureText: true,
                       keyboardType: TextInputType.visiblePassword,

                     ),
                   ),
                   Align(
                     alignment: Alignment.centerRight,
                     child: TextButton(
                       onPressed: (){
                       //  showBottomSheet(context: context, builder: (context)=>forgetPasswordView());
                       },
                       child:const Text('Forgot password?'),
                     ),
                   ),
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
                         borderRadius:BorderRadius.circular(20) ,
                         child: MaterialButton(
                           color: AppColors.buttonColor,
                           onPressed: (){
                             if(formKey.currentState!.validate())
                               {
                                 Navigator.pushAndRemoveUntil(
                                     context,
                                     MaterialPageRoute(builder: (context) =>const HomeScreen(),),
                                     (route) => true,
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
                   ),
                 ],
               ),
             ),
           ),
         ),
       ),
     );
   }

   Widget  signUpView(context)
   {
     return Container(
       height: 500,
       color: Colors.white,
       child: Padding(
         padding: const EdgeInsets.only(top: 20.0),
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Form(
               key: formKey,
               child: Column(
                 children: [
                   const Text(
                     "It's time to barter!",
                     style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: AppColors.buttonColor),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 15.0,bottom: 10),
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(15),
                         boxShadow:const [
                            BoxShadow(color: Colors.grey,blurRadius: 15),
                         ],
                       ),
                       child: TextFormField(
                         decoration: InputDecoration(
                           labelText: 'Name',
                           labelStyle:const TextStyle(height: 5),
                           prefixIcon:const Icon(Icons.person),
                           focusColor: Colors.white,
                           enabledBorder: mainBorder,
                           disabledBorder: mainBorder,
                           focusedBorder: mainBorder,
                           errorBorder: mainBorder,
                           focusedErrorBorder:mainBorder,
                         ),
                         validator: (value){
                           if(value!.isEmpty)
                           {
                             return "can't be empty!";
                           }
                           return null;
                         },
                         keyboardType: TextInputType.name,
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                     child: Container(
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
                         validator: (value){
                           if(value!.isEmpty)
                           {
                             return "can't be empty!";
                           }
                           return null;
                         },
                         keyboardType: TextInputType.emailAddress,
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(15),
                         boxShadow:const [
                            BoxShadow(color: Colors.grey,blurRadius: 15),
                         ],
                       ),
                       child: IntlPhoneField(
                         decoration: InputDecoration(
                           labelText: 'Phone Number',
                           labelStyle:const TextStyle(height: 5),
                           prefixIcon:const Icon(Icons.email),
                           focusColor: Colors.white,
                           enabledBorder: mainBorder,
                           disabledBorder: mainBorder,
                           focusedBorder: mainBorder,
                           errorBorder: mainBorder,
                           focusedErrorBorder:mainBorder,
                         ),
                         onChanged: (phone) {
                           //  print(phone.completeNumber);
                         },
                         onCountryChanged: (country) {
                           //print('Country changed to: ' + country.name);
                         },
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                         disableLengthCheck: false,
                         initialCountryCode: 'EG',
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                     child: Container(
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
                             onPressed: (){},
                             icon:const Icon(Icons.visibility),
                           ),
                           focusColor: Colors.white,
                           enabledBorder: mainBorder,
                           disabledBorder: mainBorder,
                           focusedBorder: mainBorder,
                           errorBorder: mainBorder,
                           focusedErrorBorder:mainBorder,
                         ),
                         validator: (value){
                           if(value!.isEmpty)
                           {
                             return "can't be empty!";
                           }
                           return null;
                         },
                         obscureText: true,
                         keyboardType: TextInputType.visiblePassword,
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 10.0,),
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(15),
                         boxShadow: const [
                            BoxShadow(color: Colors.grey,blurRadius: 15),
                         ],
                       ),
                       child: TextFormField(
                         decoration: InputDecoration(
                           labelText: 'Confirm Password',
                           labelStyle:const TextStyle(height: 5),
                           prefixIcon:const Icon(Icons.lock),
                           suffixIcon: IconButton(
                             onPressed: (){},
                             icon:const Icon(Icons.visibility),
                           ),
                           focusColor: Colors.white,
                           enabledBorder: mainBorder,
                           disabledBorder:mainBorder,
                           focusedBorder: mainBorder,
                           errorBorder: mainBorder,
                           focusedErrorBorder:mainBorder,
                         ),
                         validator: (value){
                           if(value!.isEmpty)
                           {
                             return "can't be empty!";
                           }
                           return null;
                         },
                         obscureText: true,
                         keyboardType: TextInputType.visiblePassword,
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all( 5.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Checkbox(value: true, onChanged: (v){
                           // print('lll');
                         },),
                         const Padding(
                           padding:  EdgeInsets.all(5.0),
                           child: Text(
                             'I agree with the',
                             style: TextStyle(fontSize: 16,),
                           ),
                         ),
                         TextButton(
                           onPressed: (){},
                           child:const Text(
                             'Terms and conditions',
                             style: TextStyle(
                               fontSize: 16,
                               color: Color(0xFFff9800),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
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
                         borderRadius:BorderRadius.circular(20) ,
                         child: MaterialButton(
                           color: AppColors.buttonColor,
                           onPressed: (){
                             if(formKey.currentState!.validate())
                             {
                               Navigator.pushAndRemoveUntil(
                                 context,
                                 MaterialPageRoute(builder: (context) =>const HomeScreen(),),
                                     (route) => true,
                               );
                             }
                           },
                           child:const Text(
                             'SIGN UP',
                             style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
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

   Widget forgetPasswordView()
   {
     return Container(
       height: 400,
       color: Colors.white,
       child: Padding(
         padding: const EdgeInsets.all(25.0),
         child: Column(
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
             const SizedBox(height: 20,),
             Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(15),
                 boxShadow:const [
                   BoxShadow(color: Colors.grey,blurRadius: 15),
                 ],
               ),
               child: TextField(
                 decoration: InputDecoration(
                   labelText: 'Email',
                   labelStyle:const TextStyle(height: 5),
                   prefixIcon:const Icon(Icons.email_outlined,color: AppColors.buttonColor,),
                   focusColor: Colors.white,
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),

                   ),
                   disabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide:const BorderSide(color: Colors.red,style: BorderStyle.solid,width: 1),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                   ),
                 ),
                 keyboardType: TextInputType.emailAddress,
               ),
             ),
             const SizedBox(height: 20,),
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
                     onPressed: (){},
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
     );
   }

   */
/// ////////////
/*  if(state is CreateUserSuccessState)
       {
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

       } */
/* else if(state is LoginSuccessState)
        {
          UID=state.uId;
          Shared.setData( key: 'uId', value: state.uId ).then((value) {
            AppCubit.get(context)..getUserData();
            //AppCubit.get(context).getAllUsers();
            Shared.setData(key: 'isLogin', value: true).then((value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,
              );
            });
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
        }*/
/*  else if(state is CreateUserErrorState )
        {
          Fluttertoast.showToast(
            msg: '${
                state.error.toString().contains('[firebase_auth/email-already-in-use]')?
                state.error.toString().replaceAll('[firebase_auth/email-already-in-use]', '')
                    : state.error.toString().replaceAll('[firebase_auth/weak-password]', '')
            }',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5,
            toastLength: Toast.LENGTH_LONG,
          );
        }*/
/*else if( state is LoginErrorState)
        {
          Fluttertoast.showToast(
            msg: '${
                state.error.toString().contains('[firebase_auth/email-already-in-use]')?
                state.error.toString().replaceAll('[firebase_auth/email-already-in-use]', '')
                    : state.error.toString().replaceAll('[firebase_auth/weak-password]', '')
            }',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5,
            toastLength: Toast.LENGTH_LONG,
          );
        }*/
/// ////////////
/* Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                 // height: 300,
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
                                                      context: context,
                                                      builder: (context)=>Container(
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
                                                    );
                                                  },
                                                  child:const Text('Forgot password?'),
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
                                                    borderRadius:BorderRadius.circular(20) ,
                                                    child: MaterialButton(
                                                      color: AppColors.buttonColor,
                                                      onPressed: (){
                                                        if(formKey.currentState!.validate())
                                                        {
                                                          AppCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                                        /*  Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(builder: (context) =>const HomeScreen(),),
                                                                (route) => true,
                                                          );*/
                                                        }
                                                      },
                                                      child:const Text(
                                                        'LOGIN',
                                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
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
                                ),
                              ) */
/// ////////////
