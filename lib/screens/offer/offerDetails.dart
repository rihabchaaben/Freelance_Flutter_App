
import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/offer/offer_cubit.dart';
import 'package:freelance_dxb/models/chat_model.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:freelance_dxb/screens/chat/chatScreen/chat_screen.dart';
import '../../cubit/offer/offer_state.dart';
import '../../models/offer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../style/style.dart';
class DetailOfferPage extends StatefulWidget {
  Offer offer;
  DetailOfferPage({Key? key, required this.offer}) : super(key: key);

  @override
  State<DetailOfferPage> createState() => _DetailOfferPageState();
}

class _DetailOfferPageState extends State<DetailOfferPage> {
 
  @override
  void initState() {
   super.initState();
  context.read<OfferCubit>().getFreelancerOfferById(widget.offer.uid!);
  }

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.local_offer_sharp,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.red),
        ),
        SizedBox(height: 10.0),
        Text(
          widget.offer.title!,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[],
        ),
      ],
    );

    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
      
   if(state is GetFreelancerSuccess){
   UserModel freelancer=state.user;
           return Scaffold(
          body: Column(
            children: <Widget>[
              Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    ),

Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.price_change,
                  color: Colors.red,
                ),
                Text("price: ",
                    style: TextStyle(fontSize: 24.0, color: Colors.red)),
                Text(
                  "${widget.offer.price!} dollar",
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: Colors.red,
                ),
                Text("description: ",
                    style: TextStyle(fontSize: 24.0, color: Colors.red)),
                Text(
                  "${widget.offer.description!}",
                  maxLines: 10,
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
             Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                Text("published by: ",
                    style: TextStyle(fontSize: 24.0, color: Colors.red)),
                Text(
                  "${freelancer.name}",
                  maxLines: 10,
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 60,),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
            ChatModel  chatFreelancer= ChatModel(id: freelancer.uid, imageUrl: freelancer.image, userName: freelancer.name);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ChatScreen(chatFreelancer);
                }));
              },
              style: startBtnStyle,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 30.0,
                ),
                child: Text(
                  "Contact ${freelancer.name} in chat",
                  style: TextStyle(fontSize: 18,color:Colors.white),
                ),
              ),
            ),
          ],
        )
          ],
        ),
      ),
    )

            ],
          ),
        );
        }
        return Center(
          child: CircularProgressIndicator(color: Colors.red),
        );

      },
    );
  }
}
