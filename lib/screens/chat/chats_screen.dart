
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/models/user_model.dart';
import 'package:barter_it/screens/show_chat/show_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget
{
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder:(context, state) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(translate(context,"Chats")!, style: const TextStyle(color: Colors.black,fontSize: 25)),
            const SizedBox(height: 16),
            AppCubit.get(context).allUsers.length>0?
            ListView.separated(
                itemBuilder: (context, index) {
                  return chatItemBuilder(AppCubit.get(context).allUsers[index],context);
                },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                separatorBuilder:(context, index)=> SizedBox(height: 20,),
                itemCount: AppCubit.get(context).allUsers.length,
            )
                :Expanded(child: Center(child: Text(translate(context, "No Chats")!))),
          ],
        )

      );
      },
    );
  }
}


Widget chatItemBuilder(UserModel model,context)
{
  return InkWell(
    onTap: (){
      // AppCubit.get(context).messages=[];
      Navigator.push(context, MaterialPageRoute(builder: (context) =>ShowChatScreen(model: model) ,));
    },
    child: Row(
      children: [
        CircleAvatar(
          radius:30.0,
           backgroundImage:NetworkImage('${model.image}'),
        ),
        SizedBox(width:15.0),
        Text(
          '${model.name}',
          style: TextStyle(fontSize: 16,),
        ),
      ],
    ),
  );
}