
import 'package:barter_it/components/components.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class EditProfileView extends StatefulWidget {
   EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? ageController;
  var formKey=GlobalKey<FormState>();

   @override
   void initState() {

      nameController=TextEditingController(text: AppCubit.get(context).userData!.name!);
      phoneController=TextEditingController(text: AppCubit.get(context).userData!.phone!);
      ageController=TextEditingController(text: AppCubit.get(context).userData!.age!.toString());

     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Edit profile'),
            foregroundColor: Colors.white,
            backgroundColor:AppColors.buttonColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.buttonColor,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    /// Image Selection
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AppCubit.get(context).userData!.image== null
                            && AppCubit.get(context).userData!.image== ""
                            && AppCubit.get(context).profileImage == null ?
                        CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.black,
                        ):
                        CircleAvatar(
                          radius: 120,
                          backgroundImage:
                          AppCubit.get(context).profileImage != null?
                          FileImage(AppCubit.get(context).profileImage!)
                              :NetworkImage(AppCubit.get(context).userData!.image!) as ImageProvider,
                        ),
                        IconButton(
                          onPressed: (){
                            AppCubit.get(context).pickProfileImage();
                          },
                          icon: Icon(Icons.camera_alt,color: AppColors.buttonColor,size: 30,),
                        ),
                      ],
                    ),
                    /// NameField
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5),blurRadius: 10,),
                          ],
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0,),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle:const TextStyle(height: 2,color: AppColors.buttonColor,fontSize: 20,),
                              prefixIcon: Icon(Icons.person,color: AppColors.buttonColor,),
                              focusColor: Colors.white,
                              enabledBorder:editBorder ,
                              disabledBorder: editBorder,
                              focusedBorder: editBorder,
                              errorBorder: editBorder,
                              focusedErrorBorder:editBorder,
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
                    ),
                    /// PhoneField
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5),blurRadius: 10,),
                          ],
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0,bottom: 0),
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle:const TextStyle(height: 1,color: AppColors.buttonColor,fontSize: 20,),
                              focusColor: Colors.white,
                              enabledBorder:editBorder ,
                              disabledBorder: editBorder,
                              focusedBorder: editBorder,
                              errorBorder: editBorder,
                              focusedErrorBorder:editBorder,
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
                    ),
                    /// Gender Field
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5),blurRadius: 10,),
                          ],
                        ),
                        height: 80,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all( 5.0),
                          child: Row(
                            children: [
                              Icon(Icons.person_outline,color: AppColors.buttonColor,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gender',
                                      style: const TextStyle(color: AppColors.buttonColor,fontSize: 16,),
                                    ),
                                    DropdownButton(
                                        underline: SizedBox(),
                                        value: AppCubit.get(context).gender,
                                        isExpanded: true,
                                        items: [
                                          DropdownMenuItem<String>(child:Text('Male'),value: 'Male', ),
                                          DropdownMenuItem<String>(child:Text('Female'), value: 'Female',),
                                          DropdownMenuItem<String>(child:Text('None'), value: 'None',),
                                        ],
                                        onChanged: (value){
                                          AppCubit.get(context).changeGender(value.toString());
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /// Age Field
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5),blurRadius: 10,),
                          ],
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0,bottom: 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Age',
                              labelStyle:const TextStyle(height: 2,color: AppColors.buttonColor,fontSize: 20,),
                              prefixIcon: Icon(Icons.person_pin_rounded,color: AppColors.buttonColor,),
                              focusColor: Colors.white,
                              enabledBorder:editBorder ,
                              disabledBorder: editBorder,
                              focusedBorder: editBorder,
                              errorBorder: editBorder,
                              focusedErrorBorder:editBorder,
                            ),
                            controller: ageController,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "can't be empty!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),

                    state is! UploadProfileImageLoadingState && state is! UpdateUserLoadingState ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 50,
                        width: 150,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(20) ,
                          child: MaterialButton(
                            color: AppColors.buttonColor,
                            onPressed: (){

                              if(formKey.currentState!.validate())
                              {
                                AppCubit.get(context).profileImage == null?
                                AppCubit.get(context).updateUserProfile(
                                  name: nameController!.text,
                                  phone: phoneController!.text,
                                  gender: AppCubit.get(context).gender,
                                  age: int.parse(ageController!.text),)

                                    :AppCubit.get(context).updateImageProfile(
                                  name: nameController!.text,
                                  phone: phoneController!.text,
                                  gender: AppCubit.get(context).gender,
                                  age: int.parse(ageController!.text),
                                ) ;
                              }

                            },

                            child:const Text(
                              'Save Changes',
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),
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
        );
      },

    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController?.dispose();
    phoneController?.dispose();
    ageController?.dispose();
  }
}
