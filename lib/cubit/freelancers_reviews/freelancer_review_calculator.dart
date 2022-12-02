import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/classifier.dart';

import 'freelancer_review_calculator_state.dart';

class FreelancerReviewCalculatorCubit
    extends Cubit<FreelancerReviewCalculatorState> {
  final Classifier _classifier;

  FreelancerReviewCalculatorCubit(this._classifier)
      : super(FreelancerReviewCalculatorInitial()) {}

  Future<void> calculateScore(String idFreelancer) async {
    final reviewsRecordsSnapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('idFreelancer', isEqualTo: idFreelancer)
        .get();
    final reviewTexts = reviewsRecordsSnapshot.docs
        .map((item) => item.data()['comment'] as String)
        .toList();
    final rs = reviewTexts.map(_predictScore).toList();

    final negative = rs.fold(0.0, (double value, element) {
      return element[0] + value;
    });
    final negativeScore = negative / reviewTexts.length;

    final positive = rs.fold(0.0, (double value, element) {
      return element[1] + value;
    });
    final positiveScore = positive / reviewTexts.length;
    emit(FreelancerReviewCalculatorSuccessState(
      negativeScore: negativeScore,
      positiveScore: positiveScore,
    ));
  }

  List<double> _predictScore(String text) {
    final prediction = _classifier.classify(text);
    return prediction;
  }
}
