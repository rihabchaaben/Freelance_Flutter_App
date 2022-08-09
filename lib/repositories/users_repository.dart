import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserRepository {
  UserModel? userModel;
  Future<UserModel?> getUserData({uid}) async {
    final value =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    userModel = UserModel.fromJson(value.data());
    return userModel;
  }
}
