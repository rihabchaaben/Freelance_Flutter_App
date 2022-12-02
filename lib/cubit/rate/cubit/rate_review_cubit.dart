import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/cubit/rate/cubit/rate_review_state.dart';
import 'package:freelance_dxb/models/user_model.dart';

import '../../../models/reviewmodel.dart';
import '../../logIn/logIn_cubit.dart';


class RateReviewCubit extends Cubit<RateReviewState> {

    final _firestore = FirebaseFirestore.instance;

  final LogInCubit loginCubit;
  late UserModel currentUser;
  RateReviewCubit(this.loginCubit) : super(ReviewInitial()) {
    loginCubit.currentUserStream.listen((user) {
      currentUser = user;
    });
  }

Future<void> addReview({required ReviewModel review}) async {
    try {
      emit(ReviewLoading());
      var reviewcollection = _firestore.collection('reviews').doc();
   //review.setId=reviewcollection.id;
      review.id=reviewcollection.id;
      await reviewcollection.set(review.toMap());
      emit(ReviewSaveSucess());
    } catch (e) {
      emit(ReviewSaveError());
      print('error in review ');
    }

}
Future<void> UpdateRate({required String rate, required UserModel freelancer}) async {
        double newRate;

    try {
      if(rate != "0.0" && freelancer.rate != "0.0")
   newRate =(double.parse(rate) + double.parse(freelancer.rate!)) /2; 
  else 
  newRate=double.parse(rate);
  //freelancer.setRate=newRate.toString();
  freelancer.rate=newRate.toString();
  print(newRate);
      emit(RateUpdateLoading());
     await FirebaseFirestore.instance
        .collection('users').doc(freelancer.uid).set(freelancer.toMap());
      emit(RateUpdateSucess());
    } catch (e) {
     // emit(RateUpdateError());
      print('we dosnt need to update star number of freelancer');
    }

}

 Stream<QuerySnapshot<Object?>>? getCount({required String idFreelancer})  {
                     
                       final Stream<QuerySnapshot> reviewsRecords =
      FirebaseFirestore.instance.collection('reviews')
                            .where('idFreelancer',isEqualTo:idFreelancer).
                            snapshots();
                            return reviewsRecords;
}
}