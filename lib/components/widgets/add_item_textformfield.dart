
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:flutter/material.dart';
class AddItemTextFormField extends StatelessWidget {
  const AddItemTextFormField({Key? key,required this.controller,required this.type}) : super(key: key);
  final TextEditingController controller ;
  final TextInputType type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle:const TextStyle(height: 2,color: AppColors.buttonColor,fontSize: 25,),
          focusColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
        maxLines: 5,
        minLines: 1,
        controller: controller,
        validator: (value){
          if(value!.isEmpty)
          {
            return translate(context,"Can't be empty!")!;
          }
          return null;
        },
        keyboardType: type,
      ),
    );
  }
}
