
import 'package:flutter/material.dart';

import '../../models/offer_model.dart';

class DetailOfferPage extends StatelessWidget {
  final Offer offer;
  DetailOfferPage({Key? key, required this.offer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(offer.title!),
            ),
            Text(offer.description!),
            SizedBox(height: 20.0),
            Text(offer.price!),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
