import 'package:flutter/material.dart';
import 'package:freelance_dxb/screens/chat/chats.dart';
import 'package:freelance_dxb/screens/logIn/log_in.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_cubit.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:freelance_dxb/screens/offer/fetch_offers.dart';
import 'package:freelance_dxb/screens/settings/settings_screen.dart';
import 'package:freelance_dxb/shared/network/local.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentSelectedIndex = 1;
  List<String> menuItemsTitle = ["Chats", "Offers", "Profile"];
  final List<Widget> screens = [
    Chats(),
    DisplayOffers(),
    Setings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          menuItemsTitle[currentSelectedIndex],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_outlined),
            onPressed: () {},
          ),
          MaterialButton(
            onPressed: () {
              LogInCubit().signOut();
              CacheHelper.saveData(key: "isSigned", value: false);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            child: Text(
              "Sign Out",
              style: TextStyle(color: Colors.red,fontSize: 20),
            ),
          )
        ],
      ),
      body: screens[currentSelectedIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: Colors.red,
        splashColor: Colors.amberAccent,
        icons: [
          Icons.chat_sharp,
          Icons.local_offer,
          Icons.person,
        ],
        onTap: (index) {
          setState(() {
            currentSelectedIndex = index;
          });
        },
        activeIndex: currentSelectedIndex,
        gapLocation: GapLocation.none,
      ),
    );
  }
}
