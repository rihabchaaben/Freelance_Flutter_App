import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:freelance_dxb/screens/chat/chatScreen/chat_screen.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeCubit>(context)..getAllUsers(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return HomeCubit.get(context).users.length > 0
              ? RefreshIndicator(
                  onRefresh: () async {
                    HomeCubit.get(context).getAllUsers();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => userItem(
                            HomeCubit.get(context).users[index], context),
                        separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 18),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                        itemCount: HomeCubit.get(context).users.length),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.red,
                ));
        },
      ),
    );
  }
}

Widget userItem(UserModel model, context) => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      child: InkWell(
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage((model.image ?? "")),
            ),
            SizedBox(
              width: 12,
            ),
            Text(model.name ?? "")
          ],
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatScreen(model)));
        },
      ),
    );
