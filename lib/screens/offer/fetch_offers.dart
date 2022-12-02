import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_dxb/models/offer_model.dart';
import 'package:freelance_dxb/screens/offer/create_offer.dart';
import 'package:freelance_dxb/screens/offer/offerDetails.dart';
import 'package:freelance_dxb/screens/offer/update_offer.dart';

import '../../repositories/offer_repository.dart';

class DisplayOffers extends StatefulWidget {
  DisplayOffers({Key? key}) : super(key: key);

  @override
  _DisplayOffersState createState() => _DisplayOffersState();
}

class _DisplayOffersState extends State<DisplayOffers> {
  List? offers;

  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    OfferRepository().getOffersByFreelancer(Freelancerid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: StreamBuilder(
          stream: OfferRepository().getOffersByFreelancer(Freelancerid: uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['title'],style:TextStyle(fontSize: 25)),
                        subtitle: Text(
                            documentSnapshot['startDate'].toString() +
                                '  :  ' +
                                documentSnapshot['endDate'].toString(),style:TextStyle(fontSize: 18)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            //ajouter edit icon here
                            IconButton(
                                color: Colors.red,
                                icon: Icon(Icons.delete),
                                onPressed: () => OfferRepository()
                                    .deleteOffer(docid: documentSnapshot.id)),

                            IconButton(
                              color: Colors.grey,
                              icon: Icon(Icons.edit),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UpdateOffer(
                                          offer: new Offer(
                                              id: documentSnapshot.id,
                                              title: documentSnapshot['title'],
                                              description: documentSnapshot[
                                                  'description'],
                                              endDate:
                                                  documentSnapshot['endDate'],
                                              startDate:
                                                  documentSnapshot['startDate'],
                                              price:
                                                  documentSnapshot['price'])))),
                            )
                          ],
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailOfferPage(
                                    offer: new Offer(
                                        title: documentSnapshot['title'],
                                        description:
                                            documentSnapshot['description'],
                                        endDate: documentSnapshot['endDate'],
                                        startDate:
                                            documentSnapshot['startDate'],
                                        price: documentSnapshot['price'])))),
                      ));
                },
              );
            } else {
              return Center(
                  child: Text(
                "offers are Empty",
                style: TextStyle(fontSize: 25, color: Colors.black26),
              ));
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        focusColor: Colors.white10,
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateOffer()));
        },
      ),
    );
  }
}
