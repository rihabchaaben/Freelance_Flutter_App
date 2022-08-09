import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/offer_model.dart';
import '../../repositories/offer_repository.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  static OfferCubit get(context) => BlocProvider.of(context);

  OfferCubit() : super(OfferInitial());
  void addOffer(Offer offer) async {
    try {
      emit(OfferLoading());
      await OfferRepository().addOffer(offer: offer);
      emit(const OfferSuccess([]));
    } catch (e) {
      emit(OfferFailed(e.toString()));
    }
  }

  void updateOffer(Offer offer) async {
    try {
      emit(OfferLoading());
      //await OfferRepository().updateOffer(offer);
      emit(OfferSuccess([]));
    } catch (e) {
      emit(OfferFailed(e.toString()));
    }
  }

  void deleteOffer(String id) async {
    try {
      emit(OfferLoading());
      await OfferRepository().deleteOffer(docid: id);
      emit(OfferDeleted());
    } catch (e) {
      emit(OfferFailed(e.toString()));
    }
  }

  List<Offer>? OfferList;
  Offer? offerModel;
  geOfferByFreelancer({required String freelancerId}) {
    try {
      FirebaseFirestore.instance
          .collection('offers')
          .where(offerModel!.uid!, isEqualTo: freelancerId)
          .snapshots()
          .listen((event) {
        OfferList = [];
        event.docs.forEach((e) {
          OfferList!.add(Offer.fromJson(e.data()));
          print(e.data());
        });

        emit(getAllOffersLoadingState());
      });
    } catch (e) {
      emit(getAllOffersErrorState('error to load offers PLZ try again'));
    }
  }
}
