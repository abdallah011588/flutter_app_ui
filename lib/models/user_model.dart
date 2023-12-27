

import 'package:barter_it/models/address_model.dart';

class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? token;
  String? image;
  String? gender;
  int? age;
  AddressModel? location;
  // String? location;

  UserModel({
    required this.name,
    required this.email,
  required this.phone,
  required this.uId,
  required this.token,
  required this.image,
  required this.gender,
  required this.age,
  required this.location,
});

  UserModel.fromJson(Map<String,dynamic> json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    token=json['token'];
    image=json['image'];
    gender=json['gender'];
    age=json['age'];
    location=AddressModel.fromJson(json['location']);
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'token':token,
      'image':image,
      'gender':gender,
      'age':age,
      'location':location!.toJson(),
    };
  }


}