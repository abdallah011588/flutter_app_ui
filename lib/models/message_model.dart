
class messageModel
{
     String? senderId;
     String? receiverId;
     String? dateTime;
     String? text;
     String? messageImage;




    messageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
      required this.messageImage,

    });


   messageModel.fromJson(Map<String,dynamic> json)
  {
    senderId=json['senderId'];
    receiverId=json['receiverId'];
    dateTime=json['dateTime'];
    text=json['text'];
    messageImage=json['messageImage'];

  }


  Map<String,dynamic> toMap()
  {
   return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'text':text,
     'messageImage':messageImage,

   };
  }

}

/// ///////////////////////////////////////////////

class notificationModel {

   String? to;
   notificationData? notification;

  notificationModel({
    required this.to,
    required this.notification,
  });



  notificationModel.fromJson(Map<String, dynamic> json){
    to = json['to'];
    notification = notificationData.fromJson(json['notification']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['to'] = to;
    _data['notification'] = notification!.toJson();
    return _data;
  }
}

class notificationData {

  String? title;
  String? body;
  bool? mutableContent;
  String? sound;

  notificationData({
    required this.title,
    required this.body,
    required this.mutableContent,
    required this.sound,
  });


  notificationData.fromJson(Map<String, dynamic> json){
    title = json['title'];
    body = json['body'];
    mutableContent = json['mutable_content'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['body'] = body;
    _data['mutable_content'] = mutableContent;
    _data['sound'] = sound;
    _data['icon'] = "@drawable/launcher_icon";
    return _data;
  }
}



