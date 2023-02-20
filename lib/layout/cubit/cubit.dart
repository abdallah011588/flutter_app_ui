
import 'dart:io';

import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/models/product_model.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/screens/barters_view/barters_view.dart';
import 'package:barter_it/screens/chats_screen/chats_view.dart';
import 'package:barter_it/screens/home_view/home_view.dart';
import 'package:barter_it/screens/profile_view/profile_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../constants/constants.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool IsPass=true;
  IconData visibilityIcon=Icons.visibility;
  bool agreeTerms=false;
  int pageIndex = 0;
  String gender='None';
  String category='Others';
  int stepIndex = 0;
  List<String> postImages=[];


  UserModel? userData;
  void showPassword()
  {
    IsPass=!IsPass;
    visibilityIcon=IsPass?Icons.visibility_off:Icons.visibility;
    emit(ShowPasswordState());
  }

  void agreeTermsChanged(bool value)
  {
    agreeTerms=value;
    emit(AgreeTermsState());
  }

  void createUser({
  required String name,
  required String email,
  required String phone,
  required String uId,
 }){
    UserModel _userModel= UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image: "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1647347030~exp=1647347630~hmac=25ba8726740b9e357adf91054b1673e062ffaee9f1e17c864807bf6edf9beca7&w=740",
        address: 'Unknown',
        gender: 'None',
        age: 0,
        location: 'Unknown',
    );
    
    FirebaseFirestore.instance.collection('users').doc(uId).set(_userModel.toMap())
      .then((value) {

      emit(CreateUserSuccessState(uId));

    }).catchError((error){

      emit( CreateUserErrorState(error.toString()) );

    });

  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,)
      .then((value) {

      createUser(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
      );

    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }


  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {

      UID=value.user!.uid;
      emit(LoginSuccessState(value.user!.uid));
      print('${value.user!.uid} user with email : ${value.user!.email} has logged in');

    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }


  void userResetPassword({
    required String email,

  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      print(' pass reset sent ');
    }).catchError((onError){
      print(onError.toString());
    });
  }

  void getUserData()
  {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(Shared.getString( key: 'uId')).get().then((value) {
      userData=UserModel.fromJson(value.data()!);
      print(userData!.name);
      print("userData!.name33333333333333");
      print(userData!.phone);
      print(userData!.email);
      emit(GetUserDataSuccessState());
    }).catchError((onError){
      emit(GetUserDataErrorState());
      print('Error ${onError.toString()} in getting user data');
    });
  }

  void changeScreen(int index)
  {
    emit(ChangeScreenState());
    pageIndex=index;
  }

  List<Widget> screens=[
    HomeView(),
    ChatView(),
    BartersView(),
    ProfileView(),
  ];

  void changeGender(String value)
  {
  emit(ChangeGenderState());
  gender=value;
}

  void stepTapped(int index)
  {
  emit(StepTappedState());
  if(index<stepIndex)
  stepIndex = index;
}

  void stepContinue(int length)
  {
    emit(StepContinueState());
   if (stepIndex < length-1) {
     stepIndex += 1;
    }
   else
     {
       print('done');
    }
  }

  void stepCancel()
  {
    emit(StepCancelState());
    if (stepIndex > 0) {
        stepIndex -= 1;
    }
  }


  void changeCategory(String value)
  {
    emit(ChangeCategoryState());
    category=value;
  }


  ImagePicker imagePicker=ImagePicker();
  File? profileImage;
  Future pickProfileImage()async
  {
    var pickedImage= await imagePicker.pickImage(source: ImageSource.gallery);

    if(pickedImage !=null)
    {
      profileImage= File(pickedImage.path);
      emit(PickedProfileImageSuccessState());
    }
    else
    {
      print('Error in picking profile image');
      emit(PickedProfileImageErrorState());
    }
  }

  void updateUserProfile({
     String? image,
    required String name,
    required String phone,
    required String gender,
    required int age,
  }){
    emit(UpdateUserLoadingState());
    UserModel _userModel= UserModel(
      name: name,
      email: userData!.email,
      phone: phone,
      uId: userData!.uId,
      image: image??userData!.image,
      address: 'Unknown',
      gender: gender,
      age: age,
      location: 'Unknown',
    );
    FirebaseFirestore.instance.collection('users').doc(userData!.uId).update(_userModel.toMap())
        .then((value) {
          getUserData();
      emit(UpdateUserSuccessState());
     // emit(UpdateUserSuccessState());
    }).catchError((error){
      emit( UpdateUserErrorState(error.toString()) );
    });
  }



 void updateImageProfile({
  required String name,
  required String phone,
  required String gender,
  required int age,
 })
 {
  emit(UploadProfileImageLoadingState());
  firebase_storage.FirebaseStorage.instance.ref()
      .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
      .putFile(profileImage!).then((p0) {
        p0.ref.getDownloadURL().then((value) {
          updateUserProfile(
              name: name,
              phone: phone,
              gender: gender,
              age: age,
             image: value,
          );
          profileImage=null;
          emit(UploadProfileImageSuccessState());
        }).then((value) {
          emit(UploadProfileImageErrorState());

        });
  });
}



  ImagePicker multiImagePicker=ImagePicker();
  List<XFile> productImages=[];
  Future pickProductImages()async
  {
    List<XFile>? pickedImages= await imagePicker.pickMultiImage();

    if(pickedImages.isNotEmpty)
    {
      productImages.addAll(pickedImages);
      // pickedImages.forEach((element) {
      //   productImages?.add(File(element.path));
      // });
      emit(PickedProductImagesSuccessState());
    }
    else
    {
      print('Error in picking product images');
      emit(PickedProductImagesErrorState());
    }
    print(productImages.length);

  }





  void uploadProductImages({
    required String name,
    required String category,
    required String price,
    required String description,
   //required String Location,
 })async
  {
    emit(UploadProductImagesLoadingState());
    // productImages.forEach((element) {
    //   firebase_storage.FirebaseStorage.instance.ref()
    //     .child('products/${Uri.file(File(element.path).path).pathSegments.last}')
    //     .putFile(File(element.path)).then((p0) {
    //      p0.ref.getDownloadURL().then((value) {
    //     postImages.add(value);
    //       print(value);
    //       if(productImages.length)
    //     });
    //     emit(UploadProductImagesSuccessState());
    //
    //   }).catchError((onError){
    //     emit(UploadProductImagesErrorState());
    //   });
    // });

    for ( int i=0 ; i<productImages.length ; i++ )
      {
       await firebase_storage.FirebaseStorage.instance.ref()
            .child('products/${Uri.file(File(productImages[i].path).path).pathSegments.last}')
            .putFile(File(productImages[i].path)).then((p0)async {
            await p0.ref.getDownloadURL().then((value) {
            postImages.add(value);
            print(value);
          });
          emit(UploadProductImagesSuccessState());

        }).catchError((onError){
          emit(UploadProductImagesErrorState());
        });
      }
    //if(productImages.length-1==i)
    //{
      postUserProduct(name: name, category: category, price: price, description: description, images: postImages);
   // }

   // return postImages;
  }


 void postUserProduct({
  required String name,
  required String category,
  required String price,
  required String description,
  required List<String> images,
  }){
    emit(postProductLoadingState());
    ProductModel productModel=ProductModel(
      name: name,
      category: category,
      price: price,
      description: description,
      owner: userData,
      images: images,
      Location: 'Location',
    );
    FirebaseFirestore.instance.collection('products').add(productModel.toMap())
      .then((value) {
      // getUserData();
      print('done this');
      postImages=[];
       emit(postProductSuccessState());
    }).catchError((error){
      emit( postProductErrorState(error.toString()) );
    });
}








  /// CUBIT END

}






















/*
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(loginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {

      uId=value.user!.uid;
      emit(loginSuccessState(value.user!.uid));
      print(value.user!.uid+'in cubit of login');

      }).catchError((error){
       emit(loginErrorState(error.toString()));
       print(error.toString());
       });
  }
  */

/*

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){

    FirebaseMessaging.instance.getToken().then((value) {
      userModel user_Model=userModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        bio: 'bio',
        messagingToken: value!,
        image: 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1647347030~exp=1647347630~hmac=25ba8726740b9e357adf91054b1673e062ffaee9f1e17c864807bf6edf9beca7&w=740',
      );

      print('go to storage');
      FirebaseFirestore.instance.collection('users').doc(uId).set(user_Model.toMap()).then((value){
        emit(createUserSuccessState(uId));
      }).catchError((error){
        emit( createUserErrorState(error.toString()) );
      });
    });



  }


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
   })
  {
    emit(registerLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid,);
      print(value.user!.uid);
    }).catchError((error){
      emit(registerErrorState());
    });

  }


*/