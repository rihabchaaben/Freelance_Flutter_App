import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:freelance_dxb/models/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatModel model;

  ChatScreen(this.model);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getMessages(receiverId: widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (previous, current) => current is getMessagesSuccessState,
        builder: (context, state) {
          if (state is getMessagesSuccessState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                titleSpacing: 0,
                backgroundColor: Colors.white,
                title: chatName(this.widget.model, context),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: state.messages.isEmpty
                          ? Center(
                              child: Text(
                              "Chat Is Empty",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black26,
                              ),
                            ))
                          : ListView.separated(
                              key: Key("chat_messages"),
                              itemBuilder: (context, index) {
                                final currentMessage = state.messages[index];
                                if (currentMessage.isSender)
                                  return mineMessage(
                                    key: Key("$index"),
                                    text: currentMessage.text!,
                                  );
                                return otherMessage(
                                  key: Key("$index"),
                                  text: currentMessage.text!,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 5),
                              itemCount: state.messages.length,
                            ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                     validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                                              decoration: InputDecoration(
                                    hintText: "    Write your message...",
                                    border: InputBorder.none,
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      onPressed: () {},
                                    )),
                                                              controller: textController,
                                                            ),
                                )),
                            Container(
                              color: Colors.red,
                              child: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                if (_formKey.currentState!
                                                              .validate())
                                  HomeCubit.get(context).sendMessage(
                                      text: textController.text,
                                      recieverId: (widget.model.id),
                                      date: DateFormat("yyyy-MM-dd HH-mm-ss")
                                          .format(DateTime.now()));
                                  textController.text = "";
                                },
                              ),
                            ),
                            //  SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      );
    });
  }

  Widget chatName(ChatModel model, context) => Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage((model.imageUrl ??
                "https://image.freepik.com/free-photo/top-view-chopping-board-with-delicious-kebab-lemon_23-2148685530.jpg")),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            model.userName,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          )
        ],
      );

  Widget mineMessage({required Key key, required String text}) => Align(
        key: key,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(text,style: TextStyle(fontSize: 18),),
          ),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        alignment: AlignmentDirectional.centerEnd,
      );

  Widget otherMessage({required Key key, required String text}) => Align(
        key: key,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(text,style: TextStyle(fontSize: 18),),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        alignment: AlignmentDirectional.centerStart,
      );
}
