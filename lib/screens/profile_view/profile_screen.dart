import 'package:barter_it/components/widgets/profile_item.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/address/add_address.dart';
import 'package:barter_it/screens/address/view_address.dart';
import 'package:barter_it/screens/edit_profile_view/edit_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context, state) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: NotificationListener<OverscrollIndicatorNotification>(
        child:AppCubit.get(context).userData !=null?
        ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                AppCubit.get(context).userData!.image!,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return  Container(
                      height: 300,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes! : null,
                              strokeWidth: 5,
                            ),
                            SizedBox(height: 10,),
                            Text(translate(context, 'Loading...')!,style: TextStyle(color: AppColors.black,fontSize: 16,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  width: double.infinity,
                  child: Center(
                    child: Text(translate(context, "Some errors occurred! \n Can't load the image ")!,
                      style: TextStyle(color: AppColors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileView(),
                      ));
                },
                icon: Icon(
                  Icons.edit,
                  color: AppColors.buttonColor,
                ),
              ),
            ),
            ProfileItem(name: translate(context, 'Name')!,value: AppCubit.get(context).userData!.name!,icon: Icons.person),
            ProfileItem(name: translate(context, 'Gender')!, value: translate(context,AppCubit.get(context).userData!.gender!)!,icon: Icons.person_outline_outlined),
            ProfileItem(name: translate(context, 'Phone Number')!, value: AppCubit.get(context).userData!.phone!,icon: Icons.phone),
            ProfileItem(name: translate(context, 'Email')!, value: AppCubit.get(context).userData!.email!,icon: Icons.email),
            ProfileItem(name: translate(context, 'Age')!, value: AppCubit.get(context).userData!.age!.toString(),icon: Icons.calendar_month),
            InkWell(
              onTap: (){
                if(AppCubit.get(context).userData!.location!.addressName == "initialLocation")
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress(),));
                else
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAddress(userModel: AppCubit.get(context).userData!,),));
              },
              child: ProfileItem(name: translate(context, 'Location')!,value:  AppCubit.get(context).userData!.location!.addressName!,icon: Icons.location_on),
            ),
          ],
        ):SizedBox(),
        onNotification: (scroll)
        {
          scroll.disallowIndicator();
          return true;
        },
      ),
    ), listener: (context, state){});
  }
}


