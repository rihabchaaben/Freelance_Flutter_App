import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/models/user_model.dart';
import '../../models/offer_model.dart';
import 'offer_state.dart';
import 'package:intl/intl.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial()) {
    getAllOffers(DateTime.now().toString());
  }

  Offer? offerModel;
  List<Offer> offers = [];
  Future<List<Offer>> getAllOffers(String currentDate) async {
    emit(GetAllOffersLoading());
    final offerCollection =
        await FirebaseFirestore.instance.collection('offers')
        .where('endDate',isGreaterThan: currentDate)
        .get();
    offers = offerCollection.docs
        .map((element) => Offer.fromJson(element.data()))
        .toList();
    //  offers.forEach((element) => print(element.description),);
    emit(GetAllOffersSucess(offers));
    return offers;
  }

  void getFreelancerOfferById(String idFreelancer) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(idFreelancer)
        .get()
        .then((value) {
      UserModel freelancer = UserModel.fromMap(value.data());
      emit(GetFreelancerSuccess(freelancer));
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> getOfferByFreelancer(String freelancerId) async {
    emit(GetAllOffersByFreelancerLoading());
    offers = [];
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: freelancerId)
        // .orderBy('rate', descending: true)
        .snapshots()
        .listen((event) {
      offers = event.docs.map((currentData) {
        return Offer.fromJson(currentData.data());
      }).toList();

      emit(GetAllOffersByFreelancerSucess(offers));
    });
  }
}
