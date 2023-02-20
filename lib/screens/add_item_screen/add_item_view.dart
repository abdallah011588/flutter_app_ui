
import 'dart:io';

import 'package:barter_it/components/components.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/resources/colors.dart';
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
   int stepIndex = 0;
   String category='Others';

    var formKey=GlobalKey<FormState>();

    @override
  void initState() {
    nameController=TextEditingController();
    priceController=TextEditingController();
    conditionController=TextEditingController();
    descriptionController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context, state) {
       if(false)//state is UploadProductImagesSuccessState)
         {
           AppCubit.get(context).postUserProduct(
               name: nameController!.text,
               category: category,
               price: priceController!.text,
               description: descriptionController!.text,
               images: AppCubit.get(context).postImages,
           );
         }
     },
     builder: (context, state) {
       return Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
           title: Text(
             'Add new item',
             style: TextStyle(
               color: AppColors.buttonColor,
             ),
           ),
           leading: IconButton(
             icon: Icon(Icons.arrow_back),
             onPressed: (){
               Navigator.pop(context);
               AppCubit.get(context).productImages=[];
             },
           ),
         ),
         body: SingleChildScrollView(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Center(
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text(
                         'Add at least 2 pictures of your item',
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
                           'Select item images',
                           style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w400,
                           ),
                         ),
                       )
                           :Container(
                         height: 200,
                         child: ListView.builder(
                           itemBuilder: (context, index) => imageSelectionBuilder(File(AppCubit.get(context).productImages[index].path)),
                           itemCount: AppCubit.get(context).productImages.length,
                           scrollDirection: Axis.horizontal,
                         ),
                       ),
                     ],
                   ),
                 ),
               ),

               Container(
                 height: 3,
                 width: double.infinity,
                 color: Colors.grey,
               ),

               Form(
                 key: formKey,
                 child: Stepper(
                   physics: NeverScrollableScrollPhysics(),
                   currentStep:stepIndex,
                   onStepCancel: () {
                     setState(() {
                       if(stepIndex > 0) {
                         stepIndex -= 1;
                       }
                     });
                   },
                   onStepContinue: () {
                     setState(() {
                       if (stepIndex < 5-1) {
                         stepIndex += 1;
                       }
                       else
                       {
                         print('done');
                       }
                     });
                   },
                   // onStepTapped: (int index) {
                   //   AppCubit.get(context).stepTapped(index);
                   //  },
                   steps: <Step>[
                     Step(
                       title: const Text('Select Category'),
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
                                   value: category,
                                   isExpanded: true,
                                   underline: SizedBox(),
                                   dropdownColor:AppColors.drawerColor ,
                                   items: [
                                     DropdownMenuItem<String>(
                                       child:Text('Electronic Devices',style: TextStyle(fontSize: 18,),),
                                       value: 'Electronic Devices',
                                     ),
                                     DropdownMenuItem<String>(child:Text('Books and Arts',style: TextStyle(fontSize: 18),), value: 'Books and Arts',),
                                     DropdownMenuItem<String>(child:Text('Fashion',style: TextStyle(fontSize: 18),), value: 'Fashion',),
                                     DropdownMenuItem<String>(child:Text('Furniture',style: TextStyle(fontSize: 18),),value: 'Furniture', ),
                                     DropdownMenuItem<String>(child:Text('Pets and Animals',style: TextStyle(fontSize: 18),), value: 'Pets and Animals',),
                                     DropdownMenuItem<String>(child:Text('Beauty and Personal-care',style: TextStyle(fontSize: 18),), value: 'Beauty and Personal-care',),
                                     DropdownMenuItem<String>(child:Text('Health-care and Fitness',style: TextStyle(fontSize: 18),),value: 'Health-care and Fitness', ),
                                     DropdownMenuItem<String>(child:Text('Vehicles',style: TextStyle(fontSize: 18),), value: 'Vehicles',),
                                     DropdownMenuItem<String>(child:Text('Others',style: TextStyle(fontSize: 18),), value: 'Others',),
                                   ],
                                   onChanged: (value){
                                     setState(() {
                                       category=value.toString();
                                     });
                                   }
                               ),
                             ),
                           ),
                         ),

                       ),
                       isActive:stepIndex==0? true:false ,
                     ),
                     Step(
                       title: Text('Product Name'),
                       content:addItemTextFormField(nameController, TextInputType.text) ,
                       isActive:stepIndex==1? true:false ,
                     ),
                     Step(
                       title: Text('Description'),
                       content:addItemTextFormField(descriptionController, TextInputType.text) ,
                       isActive:stepIndex==2? true:false ,
                     ),
                     Step(
                       title: Text('Condition'),
                       content:addItemTextFormField(conditionController, TextInputType.text) ,
                       isActive:stepIndex==3? true:false ,
                     ),
                     Step(
                       title: Text('Money Equivalence'),
                       content:addItemTextFormField(priceController, TextInputType.number) ,
                       isActive:stepIndex==4? true:false ,
                     ),
                   ],
                 ),
               ),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   true? Padding(
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
                                   category: category,
                                   price: priceController!.text,
                                   description: descriptionController!.text,
                                 );



                               }

                             }
                           },
                           child:const Text(
                             'Submit Item',
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
                           child:const Text(
                             'Cancel',
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
    super.dispose();
    nameController?.dispose();
     priceController?.dispose();
     conditionController?.dispose();
     descriptionController?.dispose();
  }







}

Widget imageSelectionBuilder(File image)
{
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        // Container(
        //   height: 150,
        //   width: 120,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Image.asset('assets/images/item.jpg',fit: BoxFit.cover,),
        // ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(image),//Image.asset('assets/images/item.jpg',isAntiAlias: true),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white60.withOpacity(0.5),
            child: IconButton(onPressed: (){},icon: Icon(Icons.clear,color: Colors.black,),
          ),
          ),
        ),
      ],
    ),
  );
}


/*

class AddNewItemView extends StatelessWidget {
   AddNewItemView({Key? key}) : super(key: key);

   var nameController=TextEditingController();
   var descriptionController=TextEditingController();
   var priceController=TextEditingController();
   // var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add new item',
          style: TextStyle(
            color: AppColors.buttonColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

         Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add at least 2 pictures of your item',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_a_photo),
                      color: AppColors.buttonColor,
                    ),
                    false? Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 30),
                      child: Text(
                        'Select item images',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                    :Container(
                          height: 200,
                          child: ListView.builder(
                            itemBuilder: (context, index) => imageSelectionBuilder(),
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                  ],
                ),
              ),
            ),
         Container(
              height: 3,
              width: double.infinity,
              color: Colors.grey,
            ),

         Stepper(
          physics: NeverScrollableScrollPhysics(),
          currentStep: AppCubit.get(context).stepIndex,
          onStepCancel: () {
          AppCubit.get(context).stepCancel();
          },
         onStepContinue: () {
           AppCubit.get(context).stepContinue(5);
         },
         // onStepTapped: (int index) {
         //   AppCubit.get(context).stepTapped(index);
         //  },
         steps: <Step>[
          Step(
            title: const Text('Select Category'),
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
                          underline: SizedBox(),
                          value: AppCubit.get(context).category,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(child:Text('Electronic Devices'),value: 'Electronic Devices', ),
                            DropdownMenuItem<String>(child:Text('Books and Arts'), value: 'Books and Arts',),
                            DropdownMenuItem<String>(child:Text('Fashion'), value: 'Fashion',),
                            DropdownMenuItem<String>(child:Text('Furniture'),value: 'Furniture', ),
                            DropdownMenuItem<String>(child:Text('Pets and Animals'), value: 'Pets and Animals',),
                            DropdownMenuItem<String>(child:Text('Beauty and Personal-care'), value: 'None1',),
                            DropdownMenuItem<String>(child:Text('Health-care and Fitness'),value: 'Health-care and Fitness', ),
                            DropdownMenuItem<String>(child:Text('Vehicles'), value: 'Vehicles',),
                            DropdownMenuItem<String>(child:Text('Others'), value: 'Others',),
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
            title: Text('Product Name'),
            content:Padding(
              padding: const EdgeInsets.all( 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelStyle:const TextStyle(height: 2,color: AppColors.buttonColor,fontSize: 25,),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                ),
                maxLines: 5,
                minLines: 1,
                controller: nameController,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "can't be empty!";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
            ) ,
            isActive:AppCubit.get(context).stepIndex==1? true:false ,
          ),
          Step(
            title: Text('Description'),
            content:addItemTextFormField(descriptionController, TextInputType.text) ,
            isActive:AppCubit.get(context).stepIndex==2? true:false ,
          ),
          Step(
             title: Text('Condition'),
             content:addItemTextFormField(nameController, TextInputType.number) ,
             isActive:AppCubit.get(context).stepIndex==3? true:false ,
          ),
          Step(
            title: Text('Money Equivalence'),
            content:addItemTextFormField(nameController, TextInputType.number) ,
            isActive:AppCubit.get(context).stepIndex==4? true:false ,
          ),
        ],
    ),

         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             true? Padding(
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
                       print(nameController.text);
                       print(descriptionController.text);
                       print(priceController.text);
                              },
                     child:const Text(
                       'Submit Item',
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
                     child:const Text(
                       'Cancel',
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
    );
  }
}

 */

/*

Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    );

 */




