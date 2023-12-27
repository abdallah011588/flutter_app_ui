import 'package:barter_it/components/components.dart';
import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/home_layout/home_screen.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/auth/auth_cubit.dart';
import 'package:barter_it/screens/auth/auth_states.dart';
import 'package:barter_it/screens/password_reset/password_reset_view.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

var formKey = GlobalKey<FormState>();
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
     emailController=TextEditingController();
     passwordController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (context) => AuthCubit()
     ,child: BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state) {
       if(state is LoginSuccessState)
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
             msg: translate(context,'Sign in success')!,
             gravity: ToastGravity.BOTTOM,
             backgroundColor: Colors.green,
             textColor: Colors.white,
             timeInSecForIosWeb: 5,
             toastLength: Toast.LENGTH_LONG,
           );
         });
       }
       if( state is LoginErrorState)
       {
         showFlutterToast( handleError(state.error.toString()) );
       }
     },
      builder: (context, state) {
       return Padding(
         padding: MediaQuery.of(context).viewInsets,
         child: Container(
           color: Colors.white,
           child: Padding(
             padding: const EdgeInsets.only(top: 20.0),
             child: Form(
               key: formKey,
               child: SingleChildScrollView(
                 child:Padding(
                   padding:const EdgeInsets.all(20.0),
                   child:Column(
                     children: [
                       /// EMAIL TEXT_FORM_FIELD
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
                             labelStyle:const TextStyle(height: 6,fontSize: 18),
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
                       const SizedBox(
                         height: 30,
                       ),
                       /// PASSWORD TEXT_FORM_FIELD
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
                             labelText: translate(context,'Password')!,
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
                           obscureText: AuthCubit.get(context).IsPass,
                           keyboardType: TextInputType.visiblePassword,
                           controller: passwordController,
                           validator: (value){
                             if(value!.isEmpty)
                             {
                               return translate(context,"Password can't be empty!")!;
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
                           child:Text(translate(context,'Forgot password?')!),
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
                           width: 130,
                           child: ClipRRect(
                             borderRadius:BorderRadius.circular(20) ,
                             child: MaterialButton(
                               color: AppColors.buttonColor,
                               onPressed: (){
                                 if(formKey.currentState!.validate())
                                 {
                                   AuthCubit.get(context).userLogin(
                                     email: emailController.text,
                                     password: passwordController.text,
                                   );
                                 }
                               },
                               child: Text(translate(context,'LOGIN')!,
                                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
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
         ),
       );
     },
   ),);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

