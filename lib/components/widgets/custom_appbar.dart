import 'package:barter_it/resources/colors.dart';
import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key,
    required this.title,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  final void Function()? onPressed;
  final IconData? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90,
      leadingWidth: 70,
      title: Text(title),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: AppColors.drawerColor,blurRadius: 10,),
            ],
          ),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            //height: 30,
            //width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.drawerColor,blurRadius: 10),
              ],
            ),
            child: IconButton(
              onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewItemView(),));
              },
              icon: Icon(icon),
            ),
          ),
        ),
      ],
    );
  }
}
