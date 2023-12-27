
import 'package:barter_it/resources/colors.dart';
import 'package:flutter/material.dart';
class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({Key? key,required this.category,required this.categoryImage}) : super(key: key);
  final String category;
  final String categoryImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.bottomNavColor,
              blurRadius: 5,
              // spreadRadius: 3.0,
            ),
          ],
        ),
        height: 110,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Image.asset("assets/images/categories/$categoryImage",width: 60,),
            SizedBox(height: 3,),
            Text(category,overflow: TextOverflow.ellipsis,maxLines: 1,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
