import 'package:equatable/equatable.dart';

class FreelancerReviewCalculatorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FreelancerReviewCalculatorInitial
    extends FreelancerReviewCalculatorState {}

class FreelancerReviewCalculatorSuccessState
    extends FreelancerReviewCalculatorState {
  final double positiveScore;
  final double negativeScore;

  FreelancerReviewCalculatorSuccessState({
    required this.positiveScore,
    required this.negativeScore,
  });
  @override
  List<Object?> get props => [this.positiveScore, this.negativeScore];
}
