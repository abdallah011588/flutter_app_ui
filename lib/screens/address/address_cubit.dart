
import 'dart:async';

import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/address_model.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/screens/address/address_states.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressCubit extends Cubit<AddressStates>{
  AddressCubit() : super(InitialAddressState());

 static AddressCubit get(context)=>BlocProvider.of(context);

 TextEditingController addressNameController =TextEditingController();
 TextEditingController addressCityController =TextEditingController();
 TextEditingController addressStreetController =TextEditingController();

  TextEditingController? editAddressNameController;
  TextEditingController? editAddressCityController;
  TextEditingController? editAddressStreetController;

 GlobalKey<FormState> formKey=GlobalKey<FormState>();

 Completer<GoogleMapController> mapControllerCompleter = Completer();

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(28.42796133580664, 31.085749655962),
    tilt: 59.440717697143555,
    zoom: 15.151926040649414,
    bearing: 192.8334901395799,

  );

   final CameraPosition initial = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30, 31),
      tilt: 59.440717697143555,
      zoom: 10.151926040649414);


  // Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  GoogleMapController? controller ;

  CameraPosition? currentCameraPosition ;
  Position? currentLocation;
  var lat=30.0;
  var long=31.0;

  List<Marker> markers = [];

  addMarkers(LatLng latLng){
    emit(AddMarkerAddressState());
    markers.clear();
    markers.add(Marker(markerId: const MarkerId("1"),position: latLng));
    lat =latLng.latitude ;
    long =latLng.longitude;
  }

  Future getPosition(context)async
  {
    emit(GetCurrentAddressState());
    bool? service;
    LocationPermission locationPer;
    service = await Geolocator.isLocationServiceEnabled();

    if(!service)
    {
      showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text(translate(context,"Service")!),
            content: Text(translate(context,"Location service is not enabled")!),
          ),
      );
    }

    locationPer = await Geolocator.checkPermission();

    if(locationPer == LocationPermission.denied)
    {
      locationPer = await Geolocator.requestPermission();
    }
    if(locationPer == LocationPermission.always)
    {
      getLatAndLong();
    }
  }

  Future<void> getLatAndLong()async
  {
    emit(GoToCurrentAddressState());
    currentLocation = await Geolocator.getCurrentPosition();
    lat =currentLocation!.latitude ;
    long =currentLocation!.longitude;
    currentCameraPosition = CameraPosition(
      target: LatLng(lat,long),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
      bearing: 192.8334901395799,
    );
    // final GoogleMapController mapController = await controller!;
    // mapController.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition!));
    // emit(GoToCurrentSuccessAddressState());
  }

  Future<void> goToCurrentLocation() async {
    emit(AnimateToAddressState());
    final GoogleMapController mapController =await  controller!;
    if(currentCameraPosition !=null)
      getLatAndLong().then((value) {
        mapController.animateCamera( CameraUpdate.newCameraPosition(currentCameraPosition!));
      });
  }

  saveAddress(context)async
  {

    if(formKey.currentState!.validate())
      {
        UserModel? userModel;
       await FirebaseFirestore.instance.collection("users").doc(Shared.getString(key: 'uId')).get().then((value) {
          userModel = UserModel.fromJson(value.data()!);
        });
        FirebaseFirestore.instance.collection("users").doc(Shared.getString(key: 'uId')).update(
          UserModel(
              name: userModel!.name,
              email: userModel!.email,
              phone: userModel!.phone,
              uId: userModel!.uId,
            token: userModel!.token,
            image: userModel!.image,
              gender: userModel!.gender,
              age: userModel!.age,
              location: AddressModel(
                  addressName: addressNameController.text,
                  addressCity: addressCityController.text,
                  addressStreet: addressStreetController.text,
                  addressLat: lat,
                  addressLong: long,
              ),
          ).toMap()
        ).then((value) {
          AppCubit.get(context).getUserData();
          Navigator.pop(context);
        });
      }
  }

  editAddress(UserModel userModel,String name ,String city ,String street , context)async
  {

    if(formKey.currentState!.validate())
    {
      FirebaseFirestore.instance.collection("users").doc(Shared.getString(key: 'uId')).update(
          UserModel(
            name: userModel.name,
            email: userModel.email,
            phone: userModel.phone,
            uId: userModel.uId,
            token: userModel.token,
            image: userModel.image,
            gender: userModel.gender,
            age: userModel.age,
            location: AddressModel(
              addressName: name,
              addressCity: city,
              addressStreet: street,
              addressLat: lat,
              addressLong: long,
            ),
          ).toMap()
      ).then((value) {
        AppCubit.get(context).getUserData();
        Navigator.pop(context);
      });
    }
  }

}