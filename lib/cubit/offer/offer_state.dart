// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'offer_cubit.dart';

@immutable
abstract class OfferState extends Equatable {
  
  const OfferState();
  List<Object> get props => [];
  get offers => null;
}


class getAllOffersLoadingState extends OfferState {}

class getAllOffersSuccessState extends OfferState {}

class getAllOffersErrorState extends OfferState {
    final String errorMessage;
      getAllOffersErrorState(this.errorMessage);
}

class OfferInitial extends OfferState {}

class OfferLoading extends OfferState {}

class OfferSuccess extends OfferState {
  final List<Offer> offers;
  const OfferSuccess(this.offers);
  List<Object> get props => [offers];
}

class OfferFailed extends OfferState {
  final String error;
  const OfferFailed(this.error);
  List<Object> get props => [error];
}

class OfferEmpty extends OfferState {}

class OfferDeleted extends OfferState {}
