import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/freelancers_reviews/freelancer_review_calculator_state.dart';
import 'package:freelance_dxb/models/freelancer_detail.dart';
import 'package:freelance_dxb/screens/adminstration/components/app_bar_actions_item.dart';
import 'package:freelance_dxb/screens/adminstration/components/side_menu.dart';
import 'package:freelance_dxb/screens/adminstration/dashboard.dart';
import 'package:freelance_dxb/shared/components/components.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'cubit/freelancers_reviews/cubit/freelancers_reviews_cubit.dart';
import 'cubit/freelancers_reviews/cubit/freelancers_reviews_state.dart';
import 'cubit/freelancers_reviews/freelancer_review_calculator.dart';

class FreelancersReviews extends StatefulWidget {
  const FreelancersReviews({Key? key}) : super(key: key);

  @override
  State<FreelancersReviews> createState() => _FreelancersReviewsState();
}

class _FreelancersReviewsState extends State<FreelancersReviews> {
  List<double> prediction = [];
  double scorePositive = 0;
  double scoreNegative = 0;
  @override
  initState() {
    super.initState();
    context.read<FreelancersReviewsCubit>().getAllFreelancers();
  }

  // This function is called whenever the text field changes

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreelancersReviewsCubit, FreelancersReviewsState>(
      buildWhen: (pre, current) => current is GetFreelancersReviewsSuccess,
      builder: (context, state) {
        if (state is GetFreelancersReviewsSuccess) {
          final _foundFreelancers = state.freelancers;
          return Scaffold(
            drawer: const SizedBox(
              width: 100,
              child: SideMenu(),
            ),
            appBar: AppBar(
              backgroundColor: bgColor,
              title: Text('Freelancers reviews'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 46, 45, 45))),
              actions: const [AppBarActionItem()],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: Flexible(
                      child: ListView.builder(
                        itemCount: _foundFreelancers.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final freelancer = _foundFreelancers[index];
                          return BlocProvider(
                            create: (context) {
                              return FreelancerReviewCalculatorCubit(
                                context.read(),
                              );
                            },
                            child: CardFreelancerClassification(
                              freelancer: freelancer,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
              child: Column(children: []),
            ),
          ),
        );
      },
    );
  }
}

class CardFreelancerClassification extends StatefulWidget {
  const CardFreelancerClassification({
    Key? key,
    required this.freelancer,
  }) : super(key: key);

  final FreelancerDetail freelancer;

  @override
  State<CardFreelancerClassification> createState() =>
      _CardFreelancerClassificationState();
}

class _CardFreelancerClassificationState
    extends State<CardFreelancerClassification> {
  @override
  void initState() {
    context
        .read<FreelancerReviewCalculatorCubit>()
        .calculateScore(widget.freelancer.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(widget.freelancer.id),
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage((widget.freelancer.imageUrl!)),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.freelancer.userName + '.',
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
                  widget.freelancer.subCategory.reduce((value, element) => value + ' || ' + element),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.place),
                    Text(widget.freelancer.city ?? "",style: TextStyle(fontSize: 18),),
                    SizedBox(
                      width: 200,
                    ),
                    IconButton(
                        color: Colors.red,
                        //disabled_visible
                        icon: Icon(Icons.delete,size: 30,),
                        onPressed: () {
                          context
                            .read<FreelancersReviewsCubit>()
                            .deleteFreelancer(widget.freelancer);
                            context
                            .read<FreelancersReviewsCubit>();
                 Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return Dashboard();
            }));
            toast(Colors.green, "freelancer disabled successfuly", context);
                            
                            } ),
                  ],
                ),
                SizedBox(height: 5),
                BlocBuilder<FreelancerReviewCalculatorCubit,
                    FreelancerReviewCalculatorState>(
                  builder: (context, state) {
                    if (state is FreelancerReviewCalculatorSuccessState) {
                 final pourcentPositive= state.positiveScore*100;
                final pourcentNegative= state.negativeScore*100;
if(pourcentPositive >0 && pourcentNegative>0 ){
   final txtPositve=pourcentPositive.round();
   final   txtNegative=pourcentNegative.round();                 
                      return Column(

                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  new CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 13.0,
                progressColor:Colors.blue,
                animation: true,
                percent:state.positiveScore,
                center: new Text(
                  "${txtPositve}%",
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),),

                Text("Positive Reviews",style: TextStyle(fontSize: 18.0,color:Colors.black,fontWeight: FontWeight.bold,),)
                                ],
                              ),
                SizedBox(width: 20),
                Column(
                  children: [
                    new CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 13.0,
                    progressColor:Colors.red,
                    animation: true,
                    percent:state.negativeScore,
                    center: new Text(
                      "${txtNegative}%",
                      style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),),
                                    Text("Negative Reviews",style: TextStyle(fontSize: 18.0,color:Colors.black,fontWeight: FontWeight.bold),)

                  ],
                ),
                SizedBox(width: 20,),
                 Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_border_outlined,color: Colors.yellow,size: 30,),
                        Text(
                          widget.freelancer.starNumber.substring(0,3),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                                       Text("Stars",style: TextStyle(fontSize: 18.0,color:Colors.black,fontWeight: FontWeight.bold),)

                      ],
                    ),
                            ],
                          ),
                          
                        ],
                      );
}
else 
 return Column(

                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  new CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 13.0,
                progressColor:Colors.blue,
                animation: true,
                percent:state.positiveScore,
                center: new Text(
                  "${0}%",
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),),

                Text("Positive Reviews",style: TextStyle(fontSize:18,color:Colors.black,fontWeight: FontWeight.bold),)
                                ],
                              ),
                SizedBox(width: 20),
                Column(
                  children: [
                    new CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 13.0,
                    progressColor:Colors.red,
                    animation: true,
                    percent:state.negativeScore,
                    center: new Text(
                      "${0}%",
                      style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),),
                                    Text("Negative Reviews",style: TextStyle(fontSize:18,color:Colors.black,fontWeight: FontWeight.bold),)

                  ],
                ),
                SizedBox(width: 20,),
                 Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_border_outlined,color: Colors.yellow,),
                        Text(
                          widget.freelancer.starNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                                       Text("Stars",style: TextStyle(fontSize:18,color:Colors.black,fontWeight: FontWeight.bold),)

                      ],
                    ),
                            ],
                          ),
                          
                        ],
                      );

                    }
                    return Container();
                  },
                )

                //  decoration: TextDecoration.underline
              ],
            ),
          ),

          //to do subcategories display

          //to do subcategories display
        ],
      ),
    );
  }
}
