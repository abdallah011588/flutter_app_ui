
import 'dart:io';
import 'package:flutter/material.dart';

class ImageSelectionBuilder extends StatelessWidget {
  const ImageSelectionBuilder({Key? key,required this.image,required this.onPress}) : super(key: key);
  final File image ;
  final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(image),//Image.asset('assets/images/item.jpg',isAntiAlias: true),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white60.withOpacity(0.5),
              child: IconButton(
                onPressed: onPress,
                icon: Icon(Icons.clear,color: Colors.black,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
