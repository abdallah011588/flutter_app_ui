import 'dart:async';
import 'dart:io';
import 'package:barter_it/components/components.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/models/address_model.dart';
import 'package:barter_it/models/message_model.dart';
import 'package:barter_it/models/product_model.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/screens/chat/chats_screen.dart';
import 'package:barter_it/screens/home_view/home_view.dart';
import 'package:barter_it/screens/products_screen/products_screen.dart';
import 'package:barter_it/screens/profile_view/profile_screen.dart';
import 'package:barter_it/screens/settings_view/settings_view.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int pageIndex = 0;
  String gender = 'None';
  String category = 'Others';
  int stepIndex = 0;
  List<String> postImages = [];
  UserModel? userData;

  List<Widget> screens = [
    HomeView(),
    ChatsScreen(),
    SettingsView(),
    ProfileView(),
  ];

  ImagePicker imagePicker = ImagePicker();
  File? profileImage;

  ImagePicker multiImagePicker = ImagePicker();
  List<XFile> productImages = [];

  List<ProductModel> allProducts = [];

  GoogleMapController? mapControllerCompleter;

  List<ProductModel> myProducts = [];
  TextEditingController? messageController;

  void getUserData() {
    emit(GetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(Shared.getString(key: 'uId'))
        .get()
        .then((value) {
      userData = UserModel.fromJson(value.data()!);
      getMyProducts();
      getAllUsers();
      emit(GetUserDataSuccessState());
    }).catchError((onError) {
      emit(GetUserDataErrorState());
    });
  }

  void changeScreen(int index) {
    emit(ChangeScreenState());
    pageIndex = index;
  }

  void changeGender(String value) {
    emit(ChangeGenderState());
    gender = value;
  }

  void stepTapped(int index) {
    emit(StepTappedState());
    stepIndex = index;
  }

  void stepContinue(int length) {
    emit(StepContinueState());
    if (stepIndex < length - 1) {
      stepIndex += 1;
    }
  }

  void stepCancel() {
    emit(StepCancelState());
    if (stepIndex > 0) {
      stepIndex -= 1;
    }
  }

  void changeCategory(String value) {
    emit(ChangeCategoryState());
    category = value;
  }

  Future pickProfileImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(PickedProfileImageSuccessState());
    } else {
      emit(PickedProfileImageErrorState());
    }
  }

  void updateUserProfile({
    String? image,
    required String name,
    required String phone,
    required String gender,
    required int age,
    required BuildContext context,
  }) {
    emit(UpdateUserLoadingState());
    UserModel _userModel = UserModel(
      name: name,
      email: userData!.email,
      phone: phone,
      uId: userData!.uId,
      token: Shared.getString(key: 'token'),
      image: image ?? userData!.image,
      gender: gender,
      age: age,
      location: AddressModel(
        addressLong: userData!.location!.addressLong,
        addressLat: userData!.location!.addressLat,
        addressName: userData!.location!.addressName,
        addressStreet: userData!.location!.addressStreet,
        addressCity: userData!.location!.addressCity,
      ),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uId)
        .update(_userModel.toMap())
        .then((value) {
      getUserData();
      emit(UpdateUserSuccessState());
      Navigator.pop(context);
    }).catchError((error) {
      emit(UpdateUserErrorState(error.toString()));
    });
  }

  void updateImageProfile({
    required String name,
    required String phone,
    required String gender,
    required int age,
    required BuildContext context,
  }) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUserProfile(
          name: name,
          phone: phone,
          gender: gender,
          age: age,
          image: value,
          context: context,
        );
        profileImage = null;
        emit(UploadProfileImageSuccessState());
      }).then((value) {
        emit(UploadProfileImageErrorState());
      });
    });
  }

  Future pickProductImages() async {
    List<XFile>? pickedImages = await imagePicker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      productImages.addAll(pickedImages);
      // pickedImages.forEach((element) {
      //   productImages?.add(File(element.path));
      // });
      emit(PickedProductImagesSuccessState());
    } else {
      emit(PickedProductImagesErrorState());
    }
    print(productImages.length);
  }

  remoVeImageFromList(int index) {
    emit(RemoveImageFromListState());
    productImages.removeAt(index);
  }

  void uploadProductImages({
    required String name,
    required String category,
    required String price,
    required String description,
    required context,
  }) async {
    emit(UploadProductImagesLoadingState());
    for (int i = 0; i < productImages.length; i++) {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('products/${Uri.file(File(productImages[i].path).path).pathSegments.last}')
          .putFile(File(productImages[i].path))
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) {
          postImages.add(value);
        });
        emit(UploadProductImagesSuccessState());
      }).catchError((onError) {
        emit(UploadProductImagesErrorState());
      });
    }
    postUserProduct(
      name: name,
      category: category,
      price: price,
      description: description,
      images: postImages,
      context: context,
    );
  }

  void postUserProduct({
    required String name,
    required String category,
    required String price,
    required String description,
    required List<String> images,
    required context,
  }) {
    emit(postProductLoadingState());
    ProductModel productModel = ProductModel(
      id: "1",
      name: name,
      category: category,
      price: price,
      description: description,
      owner: userData,
      images: images,
    );

    FirebaseFirestore.instance.collection('product')
        .add(productModel.toMap()).then((value) {
      FirebaseFirestore.instance
          .collection('product')
          .doc(value.id)
          .update(
          ProductModel(
            id: value.id,
            name: name,
            category: category,
            price: price,
            description: description,
            owner: userData,
            images: images,
          ).toMap());
      postImages = [];
      emit(postProductSuccessState());
      getMyProducts();
      Navigator.pop(context);
    }).catchError((error) {
      emit(postProductErrorState(error.toString()));
    });
  }

  List<ProductModel> aroundProducts = [];

  Future getAllProducts() async {
    emit(GetAllProductsLoadingState());
    allProducts = [];
    await FirebaseFirestore.instance.collection('product').get().then((value) {
      value.docs.forEach((element) {
        allProducts.add(ProductModel.fromJson(element.data()));
      });
      emit(GetAllProductsSuccessState());
    }).catchError((error) {
      emit(GetAllProductsErrorState());
    });
  }

  getMyProducts() async {
    emit(GetMyProductsLoadingState());
    myProducts = [];
    await FirebaseFirestore.instance.collection("product")
        .where("owner.uId", isEqualTo: userData!.uId).get().then((value) {
      value.docs.forEach((element) {
        myProducts.add(ProductModel.fromJson(element.data()));
      });
    });
    emit(GetMyProductsSuccessState());
  }

  deleteMyProduct(String productCategory, String productId, List<String> productImages, context) async
  {
    emit(DeleteMyProductsLoadingState());
    await FirebaseFirestore.instance.collection("product")
        .doc(productId).delete()
        .then((value) {
      productImages.forEach((element) async {
        await firebase_storage.
        FirebaseStorage.instance.ref("products")
            .child(basename(element).replaceFirst("products%2F", "").split("?")[0]).delete();
      });
      emit(DeleteMyProductsSuccessState());
      myProducts.removeWhere((element) {
        return element.id == productId;
      });
      Navigator.pop(context);
    }).catchError((onError) {
      emit(DeleteMyProductsErrorState());
    });
  }

  List<ProductModel> specificProducts = [];
  Future getSpecificProducts(String category , String index ,context)async {
    emit(GetProductsLoadingState());
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(products: specificProducts , categoryIndex :index),),);
      specificProducts = [];
      await FirebaseFirestore.instance.collection('product').where("category" ,isEqualTo: category.toString())
          .get().then((value) {
        value.docs.forEach((element) {
          specificProducts.add(ProductModel.fromJson(element.data()));
        });
        emit(GetProductsSuccessState());
      }).catchError((error) {
        emit(GetProductsErrorState());
      });

  }

  /// ////////////////////////////////////////// MESSAGES ////////////////////////////////////////

  List<UserModel> allUsers = [];
  Future<void> getAllUsers()async
  {
    emit(getAllUsersLoadingState());
   await FirebaseFirestore.instance
       .collection('users')
      .doc(userData!.uId)
      .collection('chat')
      .get().then((value) {
      allUsers=[];
      value.docs.forEach((element) async{
        if(element.data()['uId'] != userData!.uId)
          {
           await FirebaseFirestore.instance.collection('users').doc(element.reference.id).get().then((val) {
              allUsers.add(UserModel.fromJson(val.data()!));
            });
          }
      });
      emit(getAllUsersSuccessState());
    }).catchError((error){
      emit(getAllUsersErrorState(error: error.toString()));
    });
  }

  File? MessageImage;
  Future<void> getMessageImage()async
  {
    var pickedFile=await imagePicker.pickImage(source:ImageSource.gallery);

    if(pickedFile !=null) {
      MessageImage=File(pickedFile.path);
      emit(getMessageImageSuccessState());
    }
    else {
      emit(getMessageImageErrorState(error: 'No Image Selected'));
    }
  }

  Future uploadMessageImage({
    required String receiverId,
    required String text,
    required String dateTime,
    required context
  }) {
    emit(UploadMessageImagesLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(MessageImage!.path).pathSegments.last}')
        .putFile(MessageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        sendMessage(
          receiverId: receiverId,
          text: text,
          messageImage: value,
          context:   context
        );
      }).catchError((error){
        emit(sendMessageErrorState(error: error.toString()));
      });
    }).catchError((error){
      emit(sendMessageErrorState(error: error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String messageImage,
    required context,
  })
  {
    emit(sendMessageLoadingState());
    messageModel msModel=messageModel(
      senderId: userData!.uId,
      receiverId: receiverId,
      dateTime: DateTime.now().toString(),
      text: text,
      messageImage: messageImage,
    );
    /// Set My Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add( msModel.toMap() ).then((value) {
      FirebaseFirestore.instance.collection('users').doc(userData!.uId).collection('chat').doc(receiverId).set({"1":"1"});
      // emit(sendMessageSuccessState());
    }).catchError((error){
      emit(sendMessageErrorState(error: error.toString()));
    });

    /// Set Receiver Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userData!.uId)
        .collection('messages')
        .add(msModel.toMap()).then((value) {
      FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chat').doc(userData!.uId).set({"1":"1"});
      // emit(sendMessageSuccessState());
    }).catchError((error){
      emit(sendMessageErrorState(error: error.toString()));
    });
    emit(sendMessageSuccessState());
  }

  void sendNotification({
        required String receiver,
        required String title,
        required String body,
      })
  {
    notificationData notifyData= notificationData(
      title: title,
      body: body,
      mutableContent: true,
      sound: 'default',
    );

    notificationModel notifyModel= notificationModel(
      to: "/topics/users${receiver}",
      // to: receiver,
      notification: notifyData,
    );
    AppDio.postData(data: notifyModel.toJson()).then( (value) {
      emit(sendNotificationSuccessState());
    }).catchError((error){
      emit(sendNotificationErrorState(error: error.toString()));
    });
  }



/// CUBIT END

}


