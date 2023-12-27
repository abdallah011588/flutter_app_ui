
import 'dart:io';

import 'package:barter_it/components/components.dart';
import 'package:barter_it/components/widgets/add_item_textformfield.dart';
import 'package:barter_it/components/widgets/custom_button.dart';
import 'package:barter_it/components/widgets/image_selection_builder.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/address/add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddNewItemView extends StatefulWidget {
   AddNewItemView({Key? key}) : super(key: key);

  @override
  State<AddNewItemView> createState() => _AddNewItemViewState();
}

class _AddNewItemViewState extends State<AddNewItemView> {

  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? conditionController;
  TextEditingController? descriptionController;

  StepState nameState=StepState.indexed;
  StepState desState=StepState.indexed;
  StepState conState=StepState.indexed;
  StepState priceState=StepState.indexed;

   var formKey = GlobalKey<FormState>();

    @override
  void initState() {
    super.initState();
    nameController=TextEditingController();
    priceController=TextEditingController();
    conditionController=TextEditingController();
    descriptionController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context, state) {},
     builder: (context, state) {
       return Stack(
         children: [
           Scaffold(
             backgroundColor: Colors.white,
             appBar: AppBar(
               title: Text(
                 translate(context ,'Add new item')!,
                 style: TextStyle(
                   color: AppColors.buttonColor,
                 ),
               ),
               toolbarHeight: 80,
               leadingWidth: 70,
               leading: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle,
                     boxShadow: [
                       BoxShadow(color: AppColors.drawerColor,blurRadius: 10,),
                     ],
                   ),
                   child: IconButton(
                     onPressed: (){
                       Navigator.pop(context);
                     },
                     icon: Icon(Icons.arrow_back),
                   ),
                 ),
               ),             ),
             body: AppCubit.get(context).userData!.location!.addressName=="initialLocation"?
              Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text(translate(context ,"Please add your Address Before")!,style: TextStyle(fontSize: 20),),
                       SizedBox(height: 20,),
                       CustomButtonAuth(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress(),));
                       }, text: "Add Address"),
                     ],
                   ),
                 )
               :ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            translate(context ,'Add at least 2 pictures of your item')!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).pickProductImages();
                            },
                            icon: Icon(Icons.add_a_photo),
                            color: AppColors.buttonColor,
                          ),
                          AppCubit.get(context).productImages.isEmpty? Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 30),
                            child: Text(
                              translate(context ,'Select item images')!,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                          :Container(
                            height: 200,
                            child: ListView.builder(
                              itemBuilder: (context, index) =>
                              ImageSelectionBuilder(
                                  image:  File(AppCubit.get(context).productImages[index].path,),
                                  onPress: ()=>  AppCubit.get(context).remoVeImageFromList(index),
                              ),
                              itemCount: AppCubit.get(context).productImages.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    height: 1,
                    color: Colors.grey,
                    thickness: 2,
                  ),

                  Form(
                    key: formKey,
                    child: Stepper(
                      physics: NeverScrollableScrollPhysics(),
                      currentStep: AppCubit.get(context).stepIndex,
                      onStepCancel: () =>AppCubit.get(context).stepCancel(),
                      onStepContinue: () =>AppCubit.get(context).stepContinue(5),
                      onStepTapped: (int index) => AppCubit.get(context).stepTapped(index),
                      steps: <Step>[
                        Step(
                          title: Text(translate(context ,'Select Category')!, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          state: AppCubit.get(context).category !=""? StepState.complete:StepState.indexed,
                          content: Container(
                            alignment: Alignment.centerLeft,
                            child:Padding(
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
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                      value: AppCubit.get(context).category,
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      dropdownColor:AppColors.drawerColor ,
                                      items: [
                                        DropdownMenuItem<String>(
                                          child:Text(translate(context ,'Electronic Devices')!,style: TextStyle(fontSize: 18,),),
                                          value: 'Electronic Devices',
                                        ),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Books and Arts')!,style: TextStyle(fontSize: 18),), value: 'Books and Arts',),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Fashion')!,style: TextStyle(fontSize: 18),), value: 'Fashion',),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Furniture')!,style: TextStyle(fontSize: 18),),value: 'Furniture', ),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Pets and Animals')!,style: TextStyle(fontSize: 18),), value: 'Pets and Animals',),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Beauty and Personal-care')!,style: TextStyle(fontSize: 18),), value: 'Beauty and Personal-care',),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Health-care and fitness')!,style: TextStyle(fontSize: 18),),value: 'Health-care and Fitness', ),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Vehicles')!,style: TextStyle(fontSize: 18),), value: 'Vehicles',),
                                        DropdownMenuItem<String>(child:Text(translate(context ,'Others')!,style: TextStyle(fontSize: 18),), value: 'Others',),
                                      ],
                                      onChanged: (value){
                                        AppCubit.get(context).changeCategory(value.toString());
                                      }
                                  ),
                                ),
                              ),
                            ),

                          ),
                          isActive:AppCubit.get(context).stepIndex==0? true:false ,
                        ),
                        Step(
                          title: Text(translate(context ,'Product Name')!, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          state: nameController!.text.isEmpty? nameState:StepState.complete,
                          content:AddItemTextFormField(controller: nameController!,type: TextInputType.text) ,
                          isActive:AppCubit.get(context).stepIndex==1? true:false ,
                        ),
                        Step(
                          title: Text(translate(context ,'Description')!, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          state: descriptionController!.text.isEmpty? desState:StepState.complete,
                          content:AddItemTextFormField(controller: descriptionController!,type: TextInputType.text) ,
                          isActive:AppCubit.get(context).stepIndex==2? true:false ,
                        ),
                        Step(
                          title: Text(translate(context ,'Condition')!, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          state: conditionController!.text.isEmpty? conState:StepState.complete,
                          content:AddItemTextFormField(controller: conditionController!,type: TextInputType.text) ,
                          isActive:AppCubit.get(context).stepIndex==3? true:false ,
                        ),
                        Step(
                          title: Text(translate(context ,'Money Equivalence')!,
                            style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          state: priceController!.text.isEmpty? priceState:StepState.complete,
                          content:AddItemTextFormField(controller: priceController!,type: TextInputType.number) ,
                          isActive:AppCubit.get(context).stepIndex==4? true:false ,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                  if(AppCubit.get(context).productImages.isNotEmpty)
                                  {
                                    AppCubit.get(context).uploadProductImages(
                                      name: nameController!.text,
                                      category: AppCubit.get(context).category,
                                      price: priceController!.text,
                                      description: descriptionController!.text,
                                      context: context,
                                    );
                                  }
                                  else
                                    {
                                      showFlutterToast(translate(context ,"Please select product images")!);
                                    }
                                }
                                else
                                {
                                  setState(() {});
                                    if(nameController!.text.isEmpty) nameState=StepState.error;

                                    if(descriptionController!.text.isEmpty) desState=StepState.error;

                                    if(conditionController!.text.isEmpty) conState=StepState.error;

                                  if(priceController!.text.isEmpty) priceState=StepState.error;

                                  }
                              },
                              child: Text(translate(context ,'Submit Item')!,
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                Navigator.pop(context);
                              },
                              child: Text(translate(context ,'Cancel')!,
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ],
               ),
           ),
           if( state is UploadProductImagesLoadingState || state is postProductLoadingState || state is UploadProductImagesSuccessState)
           Container(
             width: double.infinity,
             height: double.infinity,
             color: Colors.white.withOpacity(0.5),
             child: Center(
               child: SpinKitCircle(
                 color: AppColors.buttonColor,
                 size: 90,
                 duration: Duration(seconds:1),
               ) ,
             ),
           ),
         ],
       );
     },
   );
  }


  @override
  void didChangeDependencies() {
    AppCubit.get(context).productImages=[];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController?.dispose();
     priceController?.dispose();
     conditionController?.dispose();
     descriptionController?.dispose();
    super.dispose();
  }
}




