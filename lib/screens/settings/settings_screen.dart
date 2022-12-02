import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:freelance_dxb/screens/editProfile/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../cubit/rate/cubit/rate_review_cubit.dart';

class Setings extends StatelessWidget {
  const Setings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeCubit>(context)
        ..getUserData(uid: FirebaseAuth.instance.currentUser!.uid),
      child: BlocConsumer<HomeCubit, HomeStates>(
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
                                HomeCubit.get(context).userModel!.image ?? ""),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Center(
                        child: Text(
                            HomeCubit.get(context).userModel!.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25))),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      HomeCubit.get(context).userModel!.bio ?? "",
                      style: TextStyle(fontSize: 16),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical:50, horizontal: 7),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    HomeCubit.get(context).userModel!.rate ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Stars",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(fontSize: 20))
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: context
                              .read<RateReviewCubit>()
                              .getCount(idFreelancer:FirebaseAuth.instance.currentUser!.uid ),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                "0",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              );
                            }
                            final documentSnapshotList = snapshot.data!.docs;
                            print(documentSnapshotList.length);
                            return Text(
                              documentSnapshotList.length.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            );
                            // return
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Reviews",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                      child: RatingBar.builder(
                        initialRating:  double.parse(HomeCubit.get(context).userModel!.rate!),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemSize: 30,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(300, 30, 0, 8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen()));
                            },
                            child: Icon(
                              Icons.edit_rounded,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
        listener: (context, state) {},
      ),
    );
  }
}
