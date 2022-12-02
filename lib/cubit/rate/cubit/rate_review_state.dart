import 'package:equatable/equatable.dart';


abstract class RateReviewState extends Equatable {
    @override

  List<Object?> get props => [];
}

class ReviewInitial extends RateReviewState {

}
class ReviewLoading extends RateReviewState {

}
class ReviewSaveSucess extends RateReviewState {

}
class ReviewSaveError extends RateReviewState {

}

class RateUpdateLoading extends RateReviewState {

}
class RateUpdateSucess extends RateReviewState {

}
class RateUpdateError extends RateReviewState {

}