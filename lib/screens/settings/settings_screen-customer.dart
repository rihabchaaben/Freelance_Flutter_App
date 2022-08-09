import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/screens/editProfile/edit_profile_customer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../cubit/customer/cubit/customer_profile_cubit.dart';

class SettingsCustomer extends StatelessWidget {
  const SettingsCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CustomerProfileCubit>(context)
        ..getUserData(uid: FirebaseAuth.instance.currentUser!.uid),
      child: BlocConsumer<CustomerProfileCubit, CustomerProfileState>(
        builder: (context, state) => state is getUserLoadingState
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : RefreshIndicator(
                color: Colors.red,
                onRefresh: () async {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 65,
                          child: CircleAvatar(
                            radius: 61,
                            backgroundImage: NetworkImage(
                                CustomerProfileCubit.get(context)
                                        .userModel!
                                        .image ??
                                    ""),
                          ),
                        ),
                      ],
                    ),
                    Center(
                        child: Text(
                            CustomerProfileCubit.get(context).userModel!.name ??
                                "",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17))),
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 8.0,
                            width: 8.0,
                          ),
                          Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 8.0,
                            width: 8.0,
                          ),
                          Center(
                              child: Text(
                                  CustomerProfileCubit.get(context)
                                          .userModel!
                                          .email ??
                                      "",
                                  style:
                                      Theme.of(context).textTheme.bodyText2)),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 8.0, 0, 0.0),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileCustomerScreen()));
                              },
                              child: Icon(
                                Icons.edit_rounded,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                      child: Row(children: [
                        SizedBox(
                          height: 8.0,
                          width: 8.0,
                        ),
                        Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 8.0,
                          width: 8.0,
                        ),
                        Center(
                            child: Text(
                          CustomerProfileCubit.get(context).userModel!.phone ??
                              "",
                          style: Theme.of(context).textTheme.bodyText2,
                        ))
                      ]),
                    ),
                  ]),
                ),
              ),
        listener: (context, state) {},
      ),
    );
  }
}
