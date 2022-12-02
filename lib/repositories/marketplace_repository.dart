import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class MarketplaceRepository {
  Future<QuerySnapshot<Map<String, dynamic>>> getFreelancers() {
    try {
      final Future<QuerySnapshot<Map<String, dynamic>>> freelancersRecords =
          FirebaseFirestore.instance
              .collection('users')
              .where('role', isEqualTo: 'freelancer')
              .orderBy('rate')
              .get();
      return freelancersRecords;
    } catch (e) {
        print("error in loading freelancers from firebase");
      rethrow;
    }
  }

  Stream<QuerySnapshot<Object?>> getFreelancersByCategory(
      {required String idcat}) {
    try {
      final Stream<QuerySnapshot> freelancersRecords = FirebaseFirestore
          .instance
          .collection('users')
          .where('idcat', isEqualTo: idcat)
          .snapshots();
      return freelancersRecords;
    } catch (e) {
      rethrow;
    }
  }

  UserModel? userModel;

  UserModel? getFreelancerData({uid}) {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromMap(value.data());
    }).catchError((e) {
      print(e.toString());
    });
    return userModel;
  }
}
