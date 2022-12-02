// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:freelance_dxb/models/offer_model.dart';
import 'package:freelance_dxb/models/user_model.dart';


abstract class OfferState extends Equatable {}


class OfferInitial extends OfferState {
  @override
  List<Object> get props => [];
}

class GetAllOffersSucess extends OfferState {
  GetAllOffersSucess(this.offers);

  final List<Offer> offers;

  @override
  List<Object> get props => [offers];
}
class GetFreelancerSuccess extends OfferState{
  final UserModel user;

  GetFreelancerSuccess(this.user);
  @override
  List<Object?> get props => [user];

}

class GetAllOffersError extends OfferState {
  @override
  List<Object> get props => [];
}

class GetAllOffersLoading extends OfferState {
  @override
  List<Object> get props => [];
}


class GetAllOffersByFreelancerSucess extends OfferState {
  GetAllOffersByFreelancerSucess(this.offers);

  final List<Offer> offers;

  @override
  List<Object> get props => [offers];
}

class GetAllOffersByFreelancerError extends OfferState {
  @override
  List<Object> get props => [];
}

class GetAllOffersByFreelancerLoading extends OfferState {
  @override
  List<Object> get props => [];
}