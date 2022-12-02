import 'package:flutter/material.dart';
import 'package:freelance_dxb/models/chat_model.dart';
import 'package:freelance_dxb/screens/marketplace/rate_freelancer.dart';
import 'dart:core';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../cubit/marketplace/cubit/manage_marketplace_cubit.dart';
import '../../cubit/marketplace/cubit/manage_marketplace_state.dart';
import '../../models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat/chatScreen/chat_screen.dart';

class FreelancersList extends StatefulWidget {
  const FreelancersList({Key? key}) : super(key: key);

  @override
  State<FreelancersList> createState() => _FreelancersListState();
}

class _FreelancersListState extends State<FreelancersList> {
  List<UserModel> _foundFreelancers = [];
List<UserModel> freelancersList = [];
  @override
  initState()  {
    super.initState();
    _getFreelancers();
  _foundFreelancers=freelancersList;

  }
_getFreelancers() async {
    List<UserModel> freelancersFuture=await context.read<ManageMarketplaceCubit>().getAllFreelancers();
await Future.forEach(freelancersFuture, (UserModel user) async {
       freelancersList.add(user);
       
      });
}
  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<UserModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = freelancersList;
    } else {
      results = freelancersList
          .where((user) => user.subcategory.join()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundFreelancers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageMarketplaceCubit, ManageMarketplaceState>(
      buildWhen: (pre, current) => current is GetAllFreelancersSucess,
      builder: (context, state) {
        if (state is GetAllFreelancersSucess) {
          //_foundFreelancers=state.freelancers;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 450,
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                          labelText: '    Search for freelancer',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Flexible(
                      child: ListView.builder(
                          itemCount: _foundFreelancers.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final freelancer = _foundFreelancers[index];
                            return CardFreelancer(
                              freelancer: freelancer,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(color: Colors.red),
        );
        
      },
    );
  }
}

class CardFreelancer extends StatelessWidget {
  const CardFreelancer({
    Key? key,
    required this.freelancer,
  }) : super(key: key);

  final UserModel freelancer;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(freelancer.uid),
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage((freelancer.image!)),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  freelancer.name + '.',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
             
                Text(
                  freelancer.subcategory.reduce((value, element) => value + ' || ' + element),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.place),
                    Text(freelancer.adress,style: TextStyle(fontSize: 18),),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                if (freelancer.hourPrice != null)
                  Text(freelancer.hourPrice! + '/Hr',style: TextStyle(fontSize: 18),),
                if (freelancer.sessionPrice != null)
                  Text(freelancer.sessionPrice! + '/Session',style: TextStyle(fontSize: 18),),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: RatingBar.builder(
                    initialRating: double.parse(freelancer.rate!),
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemSize: 20,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      // print(rating);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ChatScreen(
                                ChatModel(
                                  id: freelancer.uid,
                                  imageUrl: freelancer.image,
                                  userName: freelancer.name,
                                ),
                              );
                            }),
                          );
                        },
                        icon: Icon(Icons.chat)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RateFreelancer(freelancer)));
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //  Text(freelancer.bio!),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          //to do subcategories display

          //to do subcategories display
        ],
      ),
    );
  }
}
