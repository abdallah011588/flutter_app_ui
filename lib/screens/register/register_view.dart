import 'package:barter_it/components/components.dart';
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/layout/home_layout/home_screen.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

var formKey = GlobalKey<FormState>();
var nameController=TextEditingController();
var emailController=TextEditingController();
var passwordController=TextEditingController();
var phoneController=TextEditingController();
var confirmPasswordController=TextEditingController();

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(

      listener: (context, state) {

        if(state is CreateUserSuccessState)
        {
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          phoneController.clear();
          confirmPasswordController.clear();

          UID=state.uId;
          Shared.setData( key: 'uId', value: state.uId ).then((value) {
            AppCubit.get(context).getUserData();
            //AppCubit.get(context).getAllUsers();
            Shared.setData(key: 'isLogin', value: true).then((value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,
              ).then((value) {
                 // nameController.clear();
                 // emailController.clear();
                 // passwordController.clear();
                 // phoneController.clear();
                 // confirmPasswordController.clear();
                 //
                 // nameController.dispose();
                 // emailController.dispose();
                 // passwordController.dispose();
                 // phoneController.dispose();
                 // confirmPasswordController.dispose();
              });
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

        }

        if(state is RegisterErrorState )
        {
          print('REGISTER ERROR : ${state.error}');
          Fluttertoast.showToast(
            msg: '${
                state.error.toString().contains('[firebase_auth/email-already-in-use]')?
                state.error.toString().replaceAll('[firebase_auth/email-already-in-use]', '')
                :state.error.toString().contains('[firebase_auth/invalid-email]')?
                state.error.toString().replaceAll('[firebase_auth/invalid-email]', '')
                : state.error.toString().replaceAll('[firebase_auth/weak-password]', '')
            }',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5,
            toastLength: Toast.LENGTH_LONG,
          );
        }

      },


      builder: (context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 450,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "It's time to barter!",
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: AppColors.buttonColor),
                        ),

                        /// NAME TEXT_FORM_FIELD
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
                              controller: nameController,
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

                        /// EMAIL TEXT_FORM_FIELD
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
                              controller: emailController,
                              validator: (value){
                                if(value!.isEmpty)
                                {
                                  return "can't be empty!";
                                }
                                else if(!emailController.text.contains('@gmail'))
                                {
                                  return "Email format is not correct !";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),

                        /// PHONE TEXT_FORM_FIELD
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
                              controller: phoneController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              disableLengthCheck: false,
                              initialCountryCode: 'EG',
                            ),
                          ),
                        ),

                        /// PASSWORD TEXT_FORM_FIELD
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
                              controller: passwordController,
                              validator: (value){
                                if(value!.isEmpty)
                                {
                                  return "can't be empty!";
                                }
                                else if(passwordController.text.length<6)
                                {
                                  return "password should be at least 6 characters !";
                                }
                                return null;
                              },
                              obscureText: AppCubit.get(context).IsPass,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                        ),

                        /// CONFIRM PASSWORD TEXT_FORM_FIELD
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
                                  onPressed: (){
                                    AppCubit.get(context).showPassword();
                                  },
                                  icon: Icon(AppCubit.get(context).visibilityIcon),
                                ),
                                focusColor: Colors.white,
                                enabledBorder: mainBorder,
                                disabledBorder:mainBorder,
                                focusedBorder: mainBorder,
                                errorBorder: mainBorder,
                                focusedErrorBorder:mainBorder,
                              ),
                              controller: confirmPasswordController,
                              validator: (value){
                                if(value!.isEmpty)
                                {
                                  return "can't be empty!";
                                }
                                else if(confirmPasswordController.text !=passwordController.text)
                                {
                                  return "password is not identical !";
                                }
                                return null;
                              },
                              obscureText: AppCubit.get(context).IsPass,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                        ),

                        /// AGREE TERMS ROW
                        Padding(
                          padding: const EdgeInsets.all( 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: AppCubit.get(context).agreeTerms,
                                onChanged: (v){
                                  AppCubit.get(context).agreeTermsChanged(v!);
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

                        /// MAIN SIGN UP BUTTON
                       state is !RegisterLoadingState? Padding(
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
                                  if(formKey.currentState!.validate() && AppCubit.get(context).agreeTerms==true)
                                  {
                                    AppCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
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
                        )
                       : const Center(
                          child: SpinKitCircle(
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


