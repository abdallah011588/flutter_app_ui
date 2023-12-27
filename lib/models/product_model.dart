

import 'package:barter_it/models/user_model.dart';

class ProductModel
{
  String ? id;
  String ? name;
  String ? category;
  String ? price;
  String ? description;
  UserModel ? owner;
  List<String> ? images=[];

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.owner,
    required this.images,
});


  ProductModel.fromJson(Map<String,dynamic>json)
  {
     id=json['id'];
     name=json['name'];
    category=json['category'];
    price=json['price'];
    description=json['description'];
    owner = UserModel.fromJson(json['owner']);
    json['images'].forEach((value){
       images!.add(value.toString());
     });
  }

  Map<String,dynamic> toMap()
  {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'owner': owner!.toMap(),
      'images': images,
    };
  }


}