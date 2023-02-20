import 'package:barter_it/components/components.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/edit_profile_view/edit_profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AppCubit.get(context).userData!.image==null ||AppCubit.get(context).userData!.image==null?
            Container(
              height: 180,
              width: double.infinity,
              child: Center(
                child: Text('No image'),
              ),
            )
            :Container(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                  child:FadeInImage(placeholder: AssetImage('assets/images/shop2.jpg'), image: NetworkImage(AppCubit.get(context).userData!.image!)),// Image.network(AppCubit.get(context).userData!.image!,fit: BoxFit.cover,),
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
            profileItems('Name', AppCubit.get(context).userData!.name!,Icon(
              Icons.person,
              color: AppColors.buttonColor,
            )),
            profileItems('Gender', AppCubit.get(context).userData!.gender!,Icon(
              Icons.person_outline_outlined,
              color: AppColors.buttonColor,
            )),
            profileItems('Phone Number', AppCubit.get(context).userData!.phone!,Icon(
              Icons.phone,
              color: AppColors.buttonColor,
            )),
            profileItems('Email', AppCubit.get(context).userData!.email!,Icon(
              Icons.email,
              color: AppColors.buttonColor,
            )),
            profileItems('Age', AppCubit.get(context).userData!.age!.toString(),Icon(
              Icons.calendar_month,
              color: AppColors.buttonColor,
            )),
            profileItems('Location', AppCubit.get(context).userData!.location!,Icon(
              Icons.location_on,
              color: AppColors.buttonColor,
            )),
          ],
        ),
      ),
    );
  }
}


