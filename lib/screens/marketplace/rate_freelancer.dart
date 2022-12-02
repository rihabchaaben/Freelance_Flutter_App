import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freelance_dxb/cubit/rate/cubit/rate_review_cubit.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/screens/layout/home_layout_customer.dart';
import '../../cubit/rate/cubit/rate_review_state.dart';
import '../../models/reviewmodel.dart';
import '../../shared/components/components.dart';
import '../../style/style.dart';
import 'cv_pdf_screen.dart';

class RateFreelancer extends StatefulWidget {
  UserModel usermodel;

  RateFreelancer(this.usermodel);

  @override
  State<RateFreelancer> createState() => _RateFreelancerState();
}

class _RateFreelancerState extends State<RateFreelancer> {
  bool _isLoading = true;
  late PDFDocument _pdf;
  String rate='0.0';

  void _loadFile(String url) async {
    // Load the pdf file from the internet
    
    _pdf = await PDFDocument.fromURL(url);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.usermodel.cv != null) {
      _loadFile(widget.usermodel.cv!);
    }
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: BlocBuilder<RateReviewCubit, RateReviewState>(
          builder: (context, state) {
            return Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 65,
                    child: CircleAvatar(
                      radius: 61,
                      backgroundImage:
                          NetworkImage(this.widget.usermodel.image!),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    this.widget.usermodel.name,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    this.widget.usermodel.bio!,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.usermodel.rate!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Stars",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(width: 150),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: context
                              .read<RateReviewCubit>()
                              .getCount(idFreelancer: widget.usermodel.uid),
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
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: RatingBar.builder(
                    initialRating: double.parse(widget.usermodel.rate!),
                    minRating: 0,
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
                      if (rating != null) {
                        rate = rating.toString();}
                    
                       
                    },
                  ),
                ),
                SizedBox(height: 40),
               
                ElevatedButton(
                  style: startBtnStyle,
                  child: Text('View the Resume 😍', style: startBtnTextStyle),
                  onPressed: () {

                     if(widget.usermodel.cv!=null){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CvSHow(
                                  cvUrl: widget.usermodel.cv!,
                                )));}
                                 else 
                       toast(Colors.green, "${widget.usermodel.name} dosnt uplaod his Resume ", context);
                 
                  },
                 
                ),
              
                SizedBox(height: 100),
                Form(
                     key: formKey,
                  child:Column(children: [    
                     Container(
                    width: 450,
                    child: TextFormField(
                    validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter comment";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          icon: Icon(Icons.message),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "    Write your review...",
                          fillColor: Colors.white70),
                      controller: commentController,
                    ),
                  ),
             
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: startBtnStyle,
                    // icon: Icon(Icons.send),
                    onPressed: () {
                       if (formKey.currentState!
                                                .validate()) {
                      ReviewModel review = new ReviewModel(
                          idCustomer: FirebaseAuth.instance.currentUser!.uid,
                          idFreelancer: widget.usermodel.uid,
                          comment: commentController.text,
                          rate: rate);
                      context.read<RateReviewCubit>().UpdateRate(
                          rate: rate, freelancer: widget.usermodel);
                           context.read<RateReviewCubit>().addReview(review: review);
                    
                        toast(Colors.green,
                            "rate and review successfully send ", context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeLayoutCustomer()));
                      }
                    },
                    child: Text("publish", style: startBtnTextStyle),
                  ),
                ),]),),],
                  
             
            );
          },
        ),
      ),
    );
  }
}
