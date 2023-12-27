import 'package:flutter/material.dart';

class ShowImageScreen extends StatelessWidget {

  const ShowImageScreen({Key? key,required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SizedBox.expand(
        child: InteractiveViewer(
          maxScale: 10,
          child:  Hero(
              tag: imageUrl,
              child: Image.network(imageUrl,)),
        ),
      ),
    );
  }

}
