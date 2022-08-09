import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context)
          ..getUserData(uid: FirebaseAuth.instance.currentUser!.uid),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return RefreshIndicator(
              color: Colors.red,
              onRefresh: () async {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: []),
                ),
              ),
            );
          },
        ));
  }
}
