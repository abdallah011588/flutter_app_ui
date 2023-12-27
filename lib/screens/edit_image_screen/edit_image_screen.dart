import 'dart:io';

import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/resources/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editImageScreen extends StatelessWidget {

  final File image;
  final UserModel model;

  editImageScreen({
    required this.image,
    required this.model
  }) ;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        print(state);
        if(state is sendMessageSuccessState)
          {
            Navigator.pop(context);
           // AppCubit.get(context).MessageImage=null;
          }
      },
      builder:  (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: AppColors.white,),
            ),
            actions: [
              //if(state is! appUploadImLoadingState)
              IconButton(
                onPressed: (){
                  //appCubit.get(context).removeMessageImage();
                  Navigator.pop(context);
                 // appCubit.get(context).updateImage();
                },
                icon: Icon(Icons.close,color: AppColors.white,),
              ),
            ],
          ),
          backgroundColor: Colors.black,
          body: SizedBox.expand(
            child: InteractiveViewer(
              child: Image(image: FileImage(image),),//Image.file(imageUri),
            ),
          ),

          floatingActionButton: state is sendMessageLoadingState || state is UploadMessageImagesLoadingState?
            CircularProgressIndicator():
          FloatingActionButton(
            onPressed: () {
              AppCubit.get(context).uploadMessageImage(
                receiverId: model.uId!,
                text: '',
                dateTime: DateTime.now().toString(),
                context: context
              ).then((value) {
                AppCubit.get(context).sendNotification(
                  receiver: model.uId!,
                  // receiver: model.token!,
                  title: AppCubit.get(context).userData!.name!,
                  body: 'Image',
                );
              });

            },
            child: Icon(Icons.send_outlined),
          ),

        );
      },
    );
  }
}
