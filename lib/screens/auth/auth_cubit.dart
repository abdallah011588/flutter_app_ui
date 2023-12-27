

import 'package:barter_it/constants/constants.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/address_model.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/screens/auth/auth_states.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthCubit extends Cubit<AuthState>
{
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context)=>BlocProvider.of(context);


  bool IsPass = true;
  IconData visibilityIcon = Icons.visibility;
  bool agreeTerms = false;
  String gender = 'None';
  String category = 'Others';
  int stepIndex = 0;

  UserModel? userData;

  void showPassword() {
    IsPass = !IsPass;
    visibilityIcon = IsPass ? Icons.visibility_off : Icons.visibility;
    emit(ShowPasswordState());
  }

  void agreeTermsChanged(bool value) {
    agreeTerms = value;
    emit(AgreeTermsState());
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel _userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      token: Shared.getString(key: 'token'),
      image: "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1647347030~exp=1647347630~hmac=25ba8726740b9e357adf91054b1673e062ffaee9f1e17c864807bf6edf9beca7&w=740",
      gender: 'None',
      age: 0,
      location: AddressModel(
        addressLong: 10,
        addressLat: 10,
        addressName: "initialLocation",
        addressStreet: "initialLocation",
        addressCity: "initialLocation",
      ),
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(_userModel.toMap())
        .then((value) {
          // getUserData();
      emit(CreateUserSuccessState(uId));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      UID = value.user!.uid;
      // getUserData();
      FirebaseMessaging.instance.subscribeToTopic("users${value.user!.uid}");
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  Future<void> userResetPassword({
    required String email,
    required context,
  })async {
    emit(ResetPasswordLoadingState());
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      Fluttertoast.showToast(
        msg: translate(context, 'Check your Email')!,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
      );
      emit(ResetPasswordSuccessState());
    }).catchError((onError) {
      emit(ResetPasswordErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  Future<void> getUserData()async {
    emit(GetUserDataLoadingState());
    await  FirebaseFirestore.instance
        .collection('users')
        .doc(Shared.getString(key: 'uId')).update({"token":Shared.getString(key: 'token')}).then((value){
       FirebaseFirestore.instance
          .collection('users')
          .doc(Shared.getString(key: 'uId'))
          .get()
          .then((value) {
        userData = UserModel.fromJson(value.data()!);
        emit(GetUserDataSuccessState());
      }).catchError((onError) {
        emit(GetUserDataErrorState());
      });
    });

  }

}