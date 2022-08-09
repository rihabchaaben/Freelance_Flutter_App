import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/screens/logIn/log_in.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_cubit.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:freelance_dxb/shared/network/local.dart';

import '../../cubit/customer/cubit/customer_profile_cubit.dart';

class HomeLayoutCustomer extends StatelessWidget {
  const HomeLayoutCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CustomerProfileCubit>(context),
      child: BlocConsumer<CustomerProfileCubit, CustomerProfileState>(
          builder: (context, state) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    CustomerProfileCubit.get(context).titlesCustomer[
                        CustomerProfileCubit.get(context).currentIndex],
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
                body: CustomerProfileCubit.get(context).screensCustomer[
                    CustomerProfileCubit.get(context).currentIndex],
                bottomNavigationBar: AnimatedBottomNavigationBar(
                  activeColor: Colors.red,
                  splashColor: Colors.amberAccent,
                  icons: [
                    Icons.chat_sharp,
                    Icons.shop,
                    Icons.person,
                  ],
                  onTap: (index) {
                    CustomerProfileCubit.get(context).changeIndex(index);
                  },
                  activeIndex: CustomerProfileCubit.get(context).currentIndex,
                  gapLocation: GapLocation.none,
                ),
              ),
          listener: (context, state) {}),
    );
  }
}
