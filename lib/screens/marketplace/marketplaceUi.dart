import 'package:flutter/material.dart';
import 'dart:core';

import 'package:freelance_dxb/screens/marketplace/freelancers_list.dart';
import 'package:freelance_dxb/screens/marketplace/offers_list.dart';

import '../../repositories/marketplace_repository.dart';

class MarketplaceFreelancers extends StatefulWidget {
  const MarketplaceFreelancers({Key? key}) : super(key: key);

  @override
  State<MarketplaceFreelancers> createState() => _MarketplaceState();
}

class _MarketplaceState extends State<MarketplaceFreelancers>
    with TickerProviderStateMixin {
  final MarketplaceRepository repository=new MarketplaceRepository();
@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController;
    tabController = new TabController(length: 2, vsync: this);

    var tabBarItem = new TabBar(
      tabs: [
        new Tab(
         text: "Marketplace",
          icon: new Icon(Icons.work,color: Colors.red,),
        ),
        new Tab(
            text: "Offers",
          icon: new Icon(Icons.local_offer_sharp,color: Colors.red),
        ),
      ],
      controller: tabController,
      indicatorColor: Colors.red,
    );

  return new DefaultTabController(
      length: 2,
      child:  Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          title:  Text(""),
          bottom: tabBarItem,
        ),
        body:  TabBarView(
          controller: tabController,
          children: [
           
            FreelancersList(),
            OffersList(),
          ],
        ),
      ),
    );
  }
}
