import 'package:barter_it/components/widgets/custom_button.dart';
import 'package:barter_it/components/widgets/custom_textform.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/address/address_cubit.dart';
import 'package:barter_it/screens/address/address_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressDetails extends StatelessWidget {
  const AddAddressDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child:BlocConsumer<AddressCubit,AddressStates>(
        listener: (context, state) => {},
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: Text(translate(context,"Address")!,style: const TextStyle(color: AppColors.black,fontSize: 22,),),
            leading: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.arrow_back_ios,color: AppColors.black,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed:(){
                  // AddressCubit.get(context).goToCurrentLocation();
                },
                icon:const Icon(Icons.my_location,color: AppColors.black,),
                splashRadius: 20,
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    label: translate(context,"Address Name")!,
                    hint: translate(context,"Name")!,
                    suffixIcon: Icons.title,
                    controller: AddressCubit.get(context).addressNameController,
                    valid: (val){
                      if (val!.isEmpty) {
                        return translate(context,"Can't be empty!")!;
                      }
                      if (val.length < 5) {
                        return translate(context,"Can't be less than 5!")!;
                      }
                      if (val.length > 100) {
                        return translate(context,"Can't be more than 100 !")!;
                      }
                      return null;
                    },
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 10,),
                  CustomTextFormField(
                    label: translate(context,"City Name")!,
                    hint: translate(context,"City Name")!,
                    suffixIcon: Icons.location_city_outlined,
                    controller: AddressCubit.get(context).addressCityController,
                    valid: (val){
                      if (val!.isEmpty) {
                        return translate(context,"Can't be empty!")!;
                      }
                      if (val.length < 5) {
                        return translate(context,"Can't be less than 5!")!;
                      }
                      if (val.length > 100) {
                        return translate(context,"Can't be more than 100 !")!;
                      }
                      return null;

                    },
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 10,),
                  CustomTextFormField(
                    label: translate(context,"Street Name")!,
                    hint: translate(context,"Street Name")!,
                    suffixIcon: Icons.streetview_outlined,
                    controller: AddressCubit.get(context).addressStreetController,
                    valid: (val){
                      if (val!.isEmpty) {
                        return translate(context,"Can't be empty!")!;
                      }
                      if (val.length < 5) {
                        return translate(context,"Can't be less than 5!")!;
                      }
                      if (val.length > 100) {
                        return translate(context,"Can't be more than 100 !")!;
                      }
                      return null;

                    },
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),
                  CustomButtonAuth(onPressed: (){}, text:translate(context, "Add")!),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
