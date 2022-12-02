import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/models/reviewmodel.dart';

class RatingRepository{
  final _firestore = FirebaseFirestore.instance;

  Future<void> addReview({required ReviewModel review}) async {
    try {
      var reviewcollection = _firestore.collection('reviews');
      await reviewcollection.add(review.toMap());
    } catch (e) {
      rethrow;
    }


}
/**Future<int> getReviews({required String idFreelancer}){
  try{

  } catch (e) {
      rethrow;
    }
}*/



}