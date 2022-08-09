import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/marketplace/cubit/manage_marketplace_cubit.dart';
import 'package:freelance_dxb/models/user_model.dart';

import '../../cubit/marketplace/cubit/manage_marketplace_state.dart';

class MarketplaceFreelancers extends StatefulWidget {
  const MarketplaceFreelancers({Key? key}) : super(key: key);

  @override
  State<MarketplaceFreelancers> createState() => _MarketplaceState();
}

class _MarketplaceState extends State<MarketplaceFreelancers> {
  List<UserModel> _freelancers = [];

  List<UserModel> _allFreelancers = [];

  // This list holds the data for the list view
  List<UserModel> _foundFreelancers = [];
  @override
  initState() {
    // at the beginning, all freelancers are shown
    _foundFreelancers = _allFreelancers;
    super.initState();
  }

  List<UserModel> results = [];

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allFreelancers;
    } else {
      results = _allFreelancers
          .where((user) =>
              user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
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
    return Scaffold(
      body: BlocConsumer<ManageMarketplaceCubit, ManageMarketplaceState>(
        listener: (context, stat) {
          setState(() {
            _foundFreelancers = results;
          });
        },
        builder: (context, state) {
          
          if (state is GetAllFreelancersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAllFreelancersError) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is GetAllFreelancersSucess) {
            final freelancers = state.freelancers;
            _allFreelancers = freelancers;
            _foundFreelancers = _allFreelancers;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0, 8.0, 0),
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                          labelText: 'Search',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: _foundFreelancers.isNotEmpty
                        ? ListView.builder(
                            itemCount: _foundFreelancers.length,
                            itemBuilder: (context, index) => Expanded(
                              child: Card(
                                key: ValueKey(_foundFreelancers[index].uid),
                                color: Colors.white,
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            (_foundFreelancers[index].image!)),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _foundFreelancers[index].name! +
                                                '.',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(_foundFreelancers[index]
                                                  .adress! +
                                              '                                 '),

                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.chat)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.red,
                                                  )),
                                            ],
                                          ),
                                          //  decoration: TextDecoration.underline
                                        ],
                                      ),
                                    ),
                                    if (_foundFreelancers[index].hourPrice !=
                                        null)
                                      Text(_foundFreelancers[index].hourPrice! +
                                          '/Hr' +
                                          '                                                             '),
                                    if (_foundFreelancers[index].sessionPrice !=
                                        null)
                                      Text(_foundFreelancers[index]
                                              .sessionPrice! +
                                          '/Session' +
                                          '                                                             '),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(_foundFreelancers[index].bio!),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    //to do subcategories display
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Text(
                            'No results found',
                            style: TextStyle(fontSize: 24),
                          ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
