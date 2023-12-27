import 'package:barter_it/components/widgets/receiver_message_item.dart';
import 'package:barter_it/components/widgets/sender_message_item.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/message_model.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/screens/edit_image_screen/edit_image_screen.dart';
import 'package:barter_it/screens/show_image_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowChatScreen extends StatefulWidget {
  final UserModel model;
  ShowChatScreen({required this.model,});

  @override
  State<ShowChatScreen> createState() => _ShowChatScreenState();
}

class _ShowChatScreenState extends State<ShowChatScreen> {

  TextEditingController? messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)
      {
         return BlocConsumer<AppCubit,AppStates>(
            listener: (context, state) {},
            builder:(context, state)
            {
              return WillPopScope(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    titleSpacing: 0.0,
                    title: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowImageScreen(imageUrl:widget.model.image! ),));
                          },
                          child: Hero(
                            tag: widget.model.image!,
                            child: CircleAvatar(
                              radius:25.0,
                              backgroundImage:NetworkImage('${widget.model.image}'),
                            ),
                          ),
                        ),
                        SizedBox(width:10.0),
                        Expanded(child: Text('${widget.model.name}',style: TextStyle(overflow: TextOverflow.ellipsis),)),
                      ],
                    ),
                  ) ,
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(AppCubit.get(context).userData!.uId)
                                .collection('chat')
                                .doc(widget.model.uId)
                                .collection('messages')
                                .orderBy('dateTime',descending: true)
                                .snapshots(),
                            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return NotificationListener<OverscrollIndicatorNotification>(
                                  child: ListView.separated(
                                    reverse: true,
                                    itemBuilder: (context, index)
                                    {
                                      var message = messageModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                                      if(AppCubit.get(context).userData!.uId == message.senderId)
                                        return SenderMessageItem(message:message);
                                      else
                                        return ReceiverMessageItem(message: message);
                                    },
                                    separatorBuilder: (context, index)=>SizedBox(height: 5.0,),
                                    itemCount: snapshot.data!.docs.length,
                                  ),
                                  onNotification: (notification) {
                                    notification.disallowIndicator();
                                    return true;
                                  },
                                );
                              } else {
                                return Container(child: Center(child: Text(
                                translate(context,'Chat with barters')!)),);
                              }
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadiusDirectional.circular(15.0),
                                ),
                                child:Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: translate(context,'Type your message...')!,
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.deepPurple,
                                        ),
                                        onTap: (){
                                          //  AppCubit.get(context).getMessageImage();
                                          AppCubit.get(context).MessageImage =null;
                                          AppCubit.get(context).getMessageImage().then((value){
                                            if(AppCubit.get(context).MessageImage !=null)
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) =>editImageScreen(
                                                  image:AppCubit.get(context).MessageImage!,
                                                  model: widget.model,
                                                ),
                                              ),
                                              );
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                splashRadius: 30,
                                icon: Icon( Icons.send_outlined,color: Colors.white,),
                                onPressed: (){
                                  if(messageController!.text !='') {
                                    AppCubit.get(context).sendMessage(
                                      receiverId: widget.model.uId!,
                                      text: messageController!.text,
                                      messageImage: '',
                                      context: context,
                                    );
                                    AppCubit.get(context).sendNotification(
                                      receiver: widget.model.uId!,
                                      // receiver: widget.model.token!,
                                      title: AppCubit.get(context).userData!.name!,
                                      body: '${messageController!.text}',
                                    );
                                  }
                                  messageController!.clear();
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onWillPop:() {
                  print(AppCubit.get(context).allUsers.contains(widget.model));
                  AppCubit.get(context).allUsers.contains(widget.model)? Navigator.pop(context):
                  AppCubit.get(context).getAllUsers().then((value){
                    Navigator.pop(context);
                  });
                  return Future.value(false);
                },
              );
            },
         );
      }
    );
  }
  @override
  void dispose() {
    messageController?.dispose();
    super.dispose();
  }
}


/*

import 'package:barter_it/components/widgets/receiver_message_item.dart';
import 'package:barter_it/components/widgets/sender_message_item.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/screens/edit_image_screen/edit_image_screen.dart';
import 'package:barter_it/screens/show_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowChatScreen extends StatefulWidget {
  UserModel model;
  ShowChatScreen({required this.model,});

  @override
  State<ShowChatScreen> createState() => _ShowChatScreenState();
}

class _ShowChatScreenState extends State<ShowChatScreen> {

  TextEditingController? messageController;

  @override
  void initState() {
    messageController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)
      {
        AppCubit.get(context).getMessages(receiverId: widget.model.uId!);
         return BlocConsumer<AppCubit,AppStates>(
            listener: (context, state) {},
            builder:(context, state)
            {
              return WillPopScope(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    titleSpacing: 0.0,
                    title: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowImageScreen(imageUrl:widget.model.image! ),));
                          },
                          child: Hero(
                            tag: widget.model.image!,
                            child: CircleAvatar(
                              radius:25.0,
                              backgroundImage:NetworkImage('${widget.model.image}'),
                            ),
                          ),
                        ),
                        SizedBox(width:10.0),
                        Expanded(child: Text('${widget.model.name}',style: TextStyle(overflow: TextOverflow.ellipsis),)),
                      ],
                    ),
                  ) ,
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        AppCubit.get(context).messages.length > 0?
                        Expanded(
                          child: NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (notification) {
                              notification.disallowIndicator();
                              return true;
                            },
                            child: ListView.separated(
                              // physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index)
                              {
                                var message = AppCubit.get(context).messages[index];
                                if(AppCubit.get(context).userData!.uId==message.senderId)
                                  return SenderMessageItem(message:message);
                                else
                                  return ReceiverMessageItem(message: message);
                              },
                              separatorBuilder: (context, index)=>SizedBox(height: 5.0,),
                              itemCount:AppCubit.get(context).messages.length,
                            ),
                          ),
                        )
                        :Expanded(
                          child: Container(
                            child: Center(child: Text('Chat with friends')),
                        ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadiusDirectional.circular(15.0),
                                ),
                                child:Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message...',
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.blue,
                                        ),
                                        onTap: (){
                                          //  AppCubit.get(context).getMessageImage();
                                          AppCubit.get(context).MessageImage =null;
                                          AppCubit.get(context).getMessageImage().then((value){
                                            if(AppCubit.get(context).MessageImage !=null)
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) =>editImageScreen(
                                                  image:AppCubit.get(context).MessageImage!,
                                                  model: widget.model,
                                                ),
                                              ),
                                              );
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(

                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                splashRadius: 30,
                                icon: Icon( Icons.send_outlined,color: Colors.white,),
                                onPressed: (){
                                  if(messageController!.text !='') {
                                    AppCubit.get(context).sendMessage(
                                      receiverId: widget.model.uId!,
                                      text: messageController!.text,
                                      messageImage: '',
                                      context: context,
                                    );
                                    AppCubit.get(context).sendNotification(
                                      // receiver: widget.model.uId!,
                                      receiver: widget.model.token!,
                                      title: AppCubit.get(context).userData!.name!,
                                      body: '${messageController!.text}',
                                    );
                                  }
                                  messageController!.clear();
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onWillPop:() {
                  print(AppCubit.get(context).allUsers.contains(widget.model));
                  AppCubit.get(context).allUsers.contains(widget.model)? Navigator.pop(context):
                  AppCubit.get(context).getAllUsers().then((value){
                    Navigator.pop(context);
                  });
                  return Future.value(false);
                },
              );
            },
         );
      }
    );
  }
  @override
  void dispose() {
    messageController?.dispose();
    super.dispose();
  }
}

 */