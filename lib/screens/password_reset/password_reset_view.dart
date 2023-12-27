import 'package:barter_it/components/components.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/auth/auth_cubit.dart';
import 'package:barter_it/screens/auth/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

var formKey = GlobalKey<FormState>();

class PasswordResetView extends StatefulWidget {

  const PasswordResetView({Key? key}) : super(key: key);

  @override
  State<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {


  late TextEditingController emailController;

  @override
  void initState() {
    emailController=TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (context) => AuthCubit(),
     child: BlocConsumer<AuthCubit,AuthState>(

      listener: (context, state) {},

      builder: (context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 300,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Padding(
                        padding:const  EdgeInsets.all(0.0),
                        child: Text(translate(context,'Please enter your email to get the reset password link')!,
                          style:const TextStyle(fontSize:20,fontWeight: FontWeight.w300,color: Colors.black),
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
                            BoxShadow(color: Colors.grey,blurRadius: 10),
                          ],
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: translate(context,'Email')!,
                            labelStyle:const TextStyle(height: 4),
                            prefixIcon:const Icon(Icons.email_outlined,color: AppColors.buttonColor,),
                            focusColor: Colors.white,
                            enabledBorder: mainBorder,
                            disabledBorder: mainBorder,
                            focusedBorder: mainBorder,
                            errorBorder: mainBorder,
                            focusedErrorBorder:mainBorder,
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return translate(context,"Email can't be empty!")!;
                            }
                            else if(!emailController.text.contains('@gmail'))
                            {
                              return translate(context,"Email format is not correct !")!;
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20,),

                      /// RESET PASSWORD BUTTON
                      state is !ResetPasswordLoadingState? Padding(
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
                                if(formKey.currentState!.validate())
                                {
                                  AuthCubit.get(context).userResetPassword(
                                      email: emailController.text.trim(),
                                    context: context,
                                  ).then((value) {
                                    emailController.clear();
                                  });
                                }
                              },
                              child: Text(
                                translate(context,'Reset Password')!,
                                style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      )
                       :const Center(
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
        );
      },
    ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

