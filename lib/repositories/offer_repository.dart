import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/models/offer_model.dart';

class OfferRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addOffer({required Offer offer}) async {
    try {
      var offercollection = _firestore.collection('offers').doc();
      offer.id=offercollection.id; 
           await offercollection.set(offer.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Offer>> getOffersNotExpired({required String currentDate}) {
    try {
      return _firestore
          .collection('offers')
          .where('endDate', isGreaterThanOrEqualTo: currentDate)
          .snapshots(includeMetadataChanges: true)
          .map((snapshor) => snapshor.docs
              .map((doc) => Offer.fromMap(doc.data(), doc.id))
              .toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Object?>> getOffersByFreelancer(
      {required String Freelancerid}) {
    try {
      final Stream<QuerySnapshot> offersRecords = FirebaseFirestore.instance
          .collection('offers')
          .where('uid', isEqualTo: Freelancerid)

          //   .where('idcat', isEqualTo: idCat)
          .snapshots();
      return offersRecords;
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOffers() {
    try {
      final Future<QuerySnapshot<Map<String, dynamic>>> offersRecords =
          FirebaseFirestore.instance.collection('offers').get();
      return offersRecords;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateOffer(String title, String id, String description,
      String endDate, String startDate, String price,String uid) async {
    try {
      var offercollection = _firestore.collection('offers');
      await offercollection.doc(id).update({
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'price': price,
        'uid':uid,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOffer({required String docid}) async {
    try {
      var offercollection = _firestore.collection('offers');
      await offercollection.doc(docid).delete();
    } catch (e) {
      rethrow;
    }
  }
}
