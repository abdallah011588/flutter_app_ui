
import 'package:barter_it/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputBorder mainBorder= OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
);

InputBorder editBorder= OutlineInputBorder(
  borderRadius: BorderRadius.circular(25),
  borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
);


Widget appTextFormField(
    controller ,
    TextInputType type,
    Widget icon,
    String label,
    )
{
  return Padding(
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
            labelText: label,
            labelStyle:const TextStyle(height: 2,color: AppColors.buttonColor,fontSize: 25,),
            prefixIcon: icon,
            focusColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:const BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
            ),
            disabledBorder: mainBorder,
            focusedBorder: mainBorder,
            errorBorder: mainBorder,
            focusedErrorBorder:mainBorder,
          //  prefixIconColor: AppColors.buttonColor,
           // iconColor: AppColors.buttonColor,
          ),
          readOnly: true,
          enableInteractiveSelection: false,
          controller: controller,
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
  );
}



Widget addItemTextFormField(
    controller ,
    TextInputType type,
    )
{
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
          return "can't be empty!";
        }
        return null;
      },
      keyboardType: type,
    ),
  );
}


Widget profileItems(String name,String value,Widget icon,)
{
  return Padding(
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
        padding: const EdgeInsets.all(8.0),
        child:Row(
          children: [
            icon,
            SizedBox(width: 10,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: AppColors.buttonColor,fontSize: 20,),
                ),
                Text(
                  value,
                  style: const TextStyle(height: 2,fontSize: 15,),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}







