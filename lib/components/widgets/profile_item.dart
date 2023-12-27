
import 'package:barter_it/resources/colors.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({Key? key,required this.name,required this.value,required this.icon}) : super(key: key);
  final String name;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child:Row(
            children: [
              Icon(
                icon,
                color: AppColors.buttonColor,
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: AppColors.buttonColor,fontSize: 15,),
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
}
