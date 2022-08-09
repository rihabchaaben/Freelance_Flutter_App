// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:freelance_dxb/models/user_model.dart';

abstract class ManageMarketplaceState extends Equatable {}

class ManageMarketplaceInitial extends ManageMarketplaceState {
  @override
  List<Object> get props => [];
}

class GetAllFreelancersSucess extends ManageMarketplaceState {
  GetAllFreelancersSucess(this.freelancers);

  final List<UserModel> freelancers;

  @override
  List<Object> get props => [freelancers];
}

class GetAllFreelancersError extends ManageMarketplaceState {
  @override
  List<Object> get props => [];
}

class GetAllFreelancersLoading extends ManageMarketplaceState {
  @override
  List<Object> get props => [];
}
