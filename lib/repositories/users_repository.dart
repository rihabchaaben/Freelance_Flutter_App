import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserRepository {
  Stream<UserModel> getUserData({uid}) async* {
    final value = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()));

    yield* value;
  }
}
