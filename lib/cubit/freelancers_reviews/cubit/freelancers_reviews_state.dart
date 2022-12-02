import 'package:equatable/equatable.dart';

import '../../../models/freelancer_detail.dart';
import '../../../models/user_model.dart';


abstract class FreelancersReviewsState extends Equatable {
 @override
  List<Object?> get props => [];
}

class FreelancersReviewsInitial extends FreelancersReviewsState {
 
}
class GetFreelancersReviewsLoading extends FreelancersReviewsState {
 
}
class GetFreelancersReviewsSuccess extends FreelancersReviewsState {
 GetFreelancersReviewsSuccess(this.freelancers);

  final List<FreelancerDetail> freelancers;

  @override
  List<Object> get props => [freelancers];
}
class GetFreelancersReviewsError extends FreelancersReviewsState {
 
}