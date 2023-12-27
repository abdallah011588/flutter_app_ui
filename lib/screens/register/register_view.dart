import 'package:barter_it/components/components.dart';
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/home_layout/home_screen.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/auth/auth_cubit.dart';
import 'package:barter_it/screens/auth/auth_states.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

var formKey = GlobalKey<FormState>();

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
     nameController=TextEditingController();
     emailController=TextEditingController();
     passwordController=TextEditingController();
     phoneController=TextEditingController();
     confirmPasswordController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit,AuthState>(
        listener: (context, state) {
          if(state is CreateUserSuccessState)
          {
            UID=state.uId;
            Shared.setData( key: 'uId', value: state.uId ).then((value) {
              AppCubit.get(context).getUserData();
              Shared.setData(key: 'isLogin', value: true).then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,
                );
              });
              Fluttertoast.showToast(
                msg: translate(context, 'Sign up success')!,
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
            showFlutterToast(handleRegisterError(state.error.toString()));
          }
        },

        builder: (context, state) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: (MediaQuery.of(context).size.height/2 )+50,
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
                           Text(translate(context, "It's time to barter!")!,
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
                                  BoxShadow(color: Colors.grey,blurRadius: 7),
                                ],
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: translate(context, 'Name')!,
                                  labelStyle:const TextStyle(height: 6,fontSize: 18),
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
                                    return translate(context, "Can't be empty!")!;
                                  }
                                  if (value.length < 3) {
                                    return translate(context,"Can't be less than 3!")!;
                                  }
                                  if (value.length > 100) {
                                    return translate(context,"Can't be more than 100 !")!;
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
                                  BoxShadow(color: Colors.grey,blurRadius: 7),
                                ],
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: translate(context, 'Email')!,
                                  labelStyle:const TextStyle(height: 6,fontSize: 18),
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
                                    return translate(context, "Can't be empty!")!;
                                  }
                                  else if(!emailController.text.contains('@gmail') || !emailController.text.contains('.com') )
                                  {
                                    return translate(context, "Email format isn't correct !")!;
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
                                  BoxShadow(color: Colors.grey,blurRadius: 7),
                                ],
                              ),
                              child: IntlPhoneField(
                                decoration: InputDecoration(
                                  counterText: "",
                                  labelText: translate(context, 'Phone Number')!,
                                  labelStyle:const TextStyle(height: 6,fontSize: 18),
                                  prefixIcon:const Icon(Icons.email),
                                  focusColor: Colors.white,
                                  enabledBorder: mainBorder,
                                  disabledBorder: mainBorder,
                                  focusedBorder: mainBorder,
                                  errorBorder: mainBorder,
                                  focusedErrorBorder:mainBorder,
                                ),
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
                                  BoxShadow(color: Colors.grey,blurRadius: 7),
                                ],
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: translate(context, 'Password')!,
                                  labelStyle:const TextStyle(height: 6,fontSize: 18),
                                  prefixIcon:const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      AuthCubit.get(context).showPassword();
                                    },
                                    icon: Icon(AuthCubit.get(context).visibilityIcon),
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
                                    return translate(context, "Can't be empty!")!;
                                  }
                                  else if(passwordController.text.length<6)
                                  {
                                    return translate(context, "password should be at least 6 characters !")!;
                                  }
                                  return null;
                                },
                                obscureText: AuthCubit.get(context).IsPass,
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
                                  BoxShadow(color: Colors.grey,blurRadius: 7),
                                ],
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: translate(context, 'Confirm Password')!,
                                  labelStyle:const TextStyle(height: 6,fontSize: 18),
                                  prefixIcon:const Icon(Icons.lock),
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
                                    return translate(context, "Can't be empty!")!;
                                  }
                                  else if(confirmPasswordController.text !=passwordController.text)
                                  {
                                    return translate(context, "password is not identical !")!;
                                  }
                                  return null;
                                },
                                obscureText: true,
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
                                  value: AuthCubit.get(context).agreeTerms,
                                  onChanged: (v){
                                    AuthCubit.get(context).agreeTermsChanged(v!);
                                    // print('lll');
                                  },),
                                 Padding(
                                  padding:const EdgeInsets.all(5.0),
                                  child: Text(translate(context, 'I agree with the')!,
                                    style:const TextStyle(fontSize: 16,),
                                  ),
                                ),
                                TextButton(
                                  onPressed: (){},
                                  child: Text(translate(context, 'Terms and conditions')!,
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
                                    if(formKey.currentState!.validate() && AuthCubit.get(context).agreeTerms==true)
                                    {
                                      AuthCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  child: Text(translate(context, 'SIGN UP')!,
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

      ),
    );
  }

  @override
  void dispose() {
   nameController.dispose();
     emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
   confirmPasswordController.dispose();
    super.dispose();
  }
}


