

import 'package:barter_it/models/user_model.dart';

class ProductModel
{
  String ? name;
  String ? category;
  String ? price;
  String ? description;
  UserModel ? owner;
  List<String> ? images;
  String ? Location;

  ProductModel({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.owner,
    required this.images,
    required this.Location,
});


  ProductModel.fromJson(Map<String,dynamic>json)
  {
     name=json['name'];
     category=json['category'];
     price=json['price'];
     description=json['description'];
     owner=UserModel.fromJson(json['owner']);
     json['images'].forEach((value){
       images!.add(value);
     });
     Location=json['Location'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'Location': Location,
      'owner': owner!.toMap(),
      'images': images,
    };
  }


}