import 'package:barter_it/components/widgets/custom_textform.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/address/address_cubit.dart';
import 'package:barter_it/screens/address/address_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class EditAddress extends StatefulWidget {
  const EditAddress({Key? key,required this.userModel}) : super(key: key);
  final UserModel userModel ;

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {

  TextEditingController? editAddressNameController;
  TextEditingController? editAddressCityController;
  TextEditingController? editAddressStreetController;
  List<Marker> markers = [];

  @override
  void initState() {
    editAddressNameController=TextEditingController(text: widget.userModel.location!.addressName!);
    editAddressCityController=TextEditingController(text: widget.userModel.location!.addressCity!);
    editAddressStreetController=TextEditingController(text: widget.userModel.location!.addressStreet!);
    // markers.add(Marker(markerId: MarkerId("1"),position: LatLng( widget.userModel.location!.addressLat!,  widget.userModel.location!.addressLong!)));
    super.initState();
  }

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
            title: Text(translate(context,"Edit Address")!,style: const TextStyle(color: AppColors.black,fontSize: 22,),),
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
                  CustomTextFormField(
                    label: translate(context,"Address Name")!,
                    hint: translate(context,"Name")!,
                    suffixIcon: Icons.title,
                    controller: editAddressNameController!,
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
                    },
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 10,),
                  CustomTextFormField(
                    label: translate(context,"City Name")!,
                    hint: translate(context,"City Name")!,
                    suffixIcon: Icons.location_city_outlined,
                    controller: editAddressCityController!,
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
                    },
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 10,),
                  CustomTextFormField(
                    label: translate(context,"Street Name")!,
                    hint: translate(context,"Street Name")!,
                    suffixIcon: Icons.streetview_outlined,
                    controller: editAddressStreetController!,
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
                    },
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(widget.userModel.location!.addressLat!, widget.userModel.location!.addressLong!),
                            tilt: 59.440717697143555,
                            zoom: 10.151926040649414,
                            bearing: 192.8334901395799,
                          ),
                          markers:AddressCubit.get(context).markers.isNotEmpty?
                          AddressCubit.get(context).markers.toSet() :{
                            Marker(markerId: const MarkerId("1"),position:LatLng(
                                widget.userModel.location!.addressLat!,
                                widget.userModel.location!.addressLong!
                            ),
                            ),
                          },

                          onMapCreated: (GoogleMapController controller) {
                            // AddressCubit.get(context).controller.complete(controller);
                            AddressCubit.get(context).controller=controller;
                          },
                          onTap: (latLng){
                            AddressCubit.get(context).addMarkers(latLng);
                          },
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              AddressCubit.get(context).editAddress(
                  widget.userModel,
                  editAddressNameController!.text,
                  editAddressCityController!.text,
                  editAddressStreetController!.text,
                  context,
              );
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressDetails(),));
            },
            label: Text(translate(context,'Save')!),
            icon: const Icon(Icons.cloud_upload),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  @override
  void dispose() {

    editAddressNameController!.dispose();
    editAddressCityController!.dispose();
    editAddressStreetController!.dispose();

    super.dispose();
  }

}
