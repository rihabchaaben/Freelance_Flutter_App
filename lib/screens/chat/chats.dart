import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:freelance_dxb/models/chat_model.dart';
import 'package:freelance_dxb/screens/chat/chatScreen/chat_screen.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getChatMessages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (pre, current) => current is ChatMessagesSucessState,
      builder: (context, state) {
        if (state is ChatMessagesSucessState) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.separated(
                key: Key("list_users"),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return userItem(state.chatMessages[index]);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 18),
                    child: Divider(color: Colors.grey),
                  );
                },
                itemCount: state.chatMessages.length),
          );
        }

        return Center(
          child: CircularProgressIndicator(color: Colors.red),
        );
      },
    );
  }

  Widget userItem(ChatModel model) {
    return Card(
      key: Key(model.id),
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage((model.imageUrl!)),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.userName + '.',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(

padding: EdgeInsets.fromLTRB(220, 0.0, 0, 0),                  
  child: Text(model.date!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                        ))),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    children: [
                      Text(model.lastMessage!,style: TextStyle(color:Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                   onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatScreen(model)));
        },
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
        
      ),
    );
  
  }
}
