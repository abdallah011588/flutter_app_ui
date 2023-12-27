
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/address/address_cubit.dart';
import 'package:barter_it/screens/address/address_states.dart';
import 'package:barter_it/screens/address/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewAddress extends StatelessWidget {
  const ViewAddress({Key? key,required this.userModel}) : super(key: key);
  final UserModel userModel ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..getPosition(context)..getLatAndLong(),
      child:  BlocConsumer<AddressCubit,AddressStates>(
        listener: (context, state) => {},
        builder: (context, state) =>Scaffold(
          resizeToAvoidBottomInset: false,
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
                  AddressCubit.get(context).goToCurrentLocation();
                },
                icon:const Icon(Icons.my_location,color: AppColors.black,),
                splashRadius: 20,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: AddressCubit.get(context).formKey,
              child: Column(
                children: [
                  ListTile(title: Text(translate(context,"Address Name")!,),subtitle:Text( userModel.location!.addressName!) ,leading:Icon(Icons.title,color: AppColors.primary,) ,),
                  Divider(color: Colors.black,thickness: 1,height: 1),
                  ListTile(title: Text(translate(context,"City Name")!,),subtitle:Text( userModel.location!.addressCity!) ,leading:Icon(Icons.location_city_outlined,color: AppColors.primary) ,),
                  Divider(color: Colors.black,thickness: 1,height: 1,),
                  ListTile(title: Text(translate(context,"Street Name")!,),subtitle:Text( userModel.location!.addressStreet!) ,leading:Icon(Icons.streetview_outlined,color: AppColors.primary) ,),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(userModel.location!.addressLat!, userModel.location!.addressLong!),
                            tilt: 59.440717697143555,
                            zoom: 10.151926040649414,
                            bearing: 192.8334901395799,
                          ),
                          markers:{
                            Marker(
                              markerId: const MarkerId("1"),
                              position:LatLng(userModel.location!.addressLat!, userModel.location!.addressLong!),
                            ),
                          },

                          onMapCreated: (GoogleMapController controller) {
                            // AddressCubit.get(context).controller.complete(controller);
                            AddressCubit.get(context).controller=controller;
                          },

                        )
                    ),
                  ),
                ],
              ),
            ),
          ) ,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddress(userModel: userModel),));
            },
            label: Text(translate(context,'Edit')!),
            icon: const Icon(Icons.cloud_upload),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
