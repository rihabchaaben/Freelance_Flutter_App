import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:freelance_dxb/screens/logIn/log_in.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_cubit.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:freelance_dxb/shared/network/local.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeCubit>(context),
      child: BlocConsumer<HomeCubit, HomeStates>(
          builder: (context, state) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    HomeCubit.get(context)
                        .titles[HomeCubit.get(context).currentIndex],
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
                body: HomeCubit.get(context)
                    .screens[HomeCubit.get(context).currentIndex],
                bottomNavigationBar: AnimatedBottomNavigationBar(
                  activeColor: Colors.red,
                  splashColor: Colors.amberAccent,
                  icons: [
                    Icons.chat_sharp,
                    Icons.local_offer,
                    Icons.person,
                  ],
                  onTap: (index) {
                    HomeCubit.get(context).changeIndex(index);
                  },
                  activeIndex: HomeCubit.get(context).currentIndex,
                  gapLocation: GapLocation.none,
                ),
              ),
          listener: (context, state) {}),
    );
  }
}
