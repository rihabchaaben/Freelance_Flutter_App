import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/offer/offer_cubit.dart';
import 'package:freelance_dxb/models/offer_model.dart';
import 'dart:core';
import 'package:freelance_dxb/screens/offer/offerDetails.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/offer/offer_state.dart';

class OffersList extends StatefulWidget {
  const OffersList({Key? key}) : super(key: key);

  @override
  State<OffersList> createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  List<Offer> _foundOffers = [];
  List<Offer> listOffers = [];
  @override
  initState() {
    super.initState();
   _getOffers();
  _foundOffers=listOffers;
  }
 _getOffers() async {
    List<Offer> offersFuture=await context.read<OfferCubit>().getAllOffers(DateTime.now().toString());
await Future.forEach(offersFuture, (Offer offer) async {
       listOffers.add(offer);
       
      });
}
  // This function is called whenever the text field changes
   void _runFilter(String enteredKeyword) {
    List<Offer> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = listOffers;
    } else {
      
      results = listOffers
          .where((offer) => offer.title!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }


    // Refresh the UI
    setState(() {
      _foundOffers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<OfferCubit, OfferState>(
   buildWhen: (pre, current) => current is GetAllOffersSucess,
      builder: (context, state) {
        if (state is GetAllOffersSucess) {
         // _foundOffers = state.offers;
          return Scaffold(
            body: SingleChildScrollView (
              child: Column(
                mainAxisSize: MainAxisSize.min,
                
                children: [
                
                 SizedBox(height: 20,),
                Container(
                  width: 450,
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                        labelText: '   Search for offer',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.red,
                        )),
                  ),
                ),
                SingleChildScrollView(
                  
                    child: Flexible(
                      child: ListView.builder(
                        itemCount: _foundOffers.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_foundOffers[index].id),
                          color: Colors.white,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                                          mainAxisSize: MainAxisSize.min,
            
                            children: [
                            ListTile(
                          
                                        
                    
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                  _foundOffers[index].title! + '.',
                                    style:
                                        TextStyle(color: Colors.red, fontSize: 25,fontWeight: FontWeight. bold),
                                  ),
                                ],
                              ),
                    
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text( _foundOffers[index].description! + '.',style:TextStyle( fontSize: 20)),
                                     SizedBox(
                                      height: 5,
                                    ),
                                    Row(children: [
                                      Icon(Icons.date_range,color: Colors.red,),
                                      SizedBox(width: 8,),
                                      Text("start date: "+_foundOffers[index].startDate!,style:TextStyle( fontSize: 18)),
                                    ],),
                                         SizedBox(
                                      height: 5,
                                    ),
                                    Row(children: [
                                      Icon(Icons.date_range,color: Colors.red,),
                                      SizedBox(width: 8,),
                                      Text("end date: "+_foundOffers[index].endDate!,style:TextStyle( fontSize: 18,)),
                                    ],),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailOfferPage(offer:_foundOffers[index])));
                                            },
                                            icon: Icon(Icons.display_settings)),
                    
                                        //  decoration: TextDecoration.underline
                                      ],
                                    ),
                                  ]),
                    
                              //to do subcategories display
                    
                              //to do subcategories display
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                
              ]),
            ),
          );
        }
        return RefreshIndicator(
          color: Colors.red,
          onRefresh: () async {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                              mainAxisSize: MainAxisSize.min,

                children: []),
            ),
          ),
        );
      },
    );
  }
}
