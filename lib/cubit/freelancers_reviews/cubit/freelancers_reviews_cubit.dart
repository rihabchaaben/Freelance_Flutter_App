
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_dxb/models/freelancer_detail.dart';
import 'package:freelance_dxb/shared/components/components.dart';
import '../../../models/user_model.dart';
import 'freelancers_reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FreelancersReviewsCubit extends Cubit<FreelancersReviewsState> {
  FreelancersReviewsCubit() : super(FreelancersReviewsInitial()) {
    getAllFreelancers();
  }
  UserModel? userModel;
  final _firestore = FirebaseFirestore.instance;

  Future<void> getAllFreelancers() async {
    emit(GetFreelancersReviewsLoading());
    final freelancerSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'freelancer')
        .orderBy('rate', descending: true)
        .get();

    final freelancers = freelancerSnapshot.docs
        .map((item) => FreelancerDetail.fromJson(item.data()))
        .toList();

    emit(GetFreelancersReviewsSuccess(freelancers));
  }

  Future<void> deleteFreelancer(FreelancerDetail freelancer) async {
    try {
    final Credentials= EmailAuthProvider.credential(email: freelancer.email, password: freelancer.password);
    final userCredential =
    await FirebaseAuth.instance.signInWithCredential(Credentials);
final user = userCredential.user;
print( user?.uid);
print(user?.email);
await user?.delete();
freelancer.role="disabledFreelancer";
await FirebaseFirestore.instance
        .collection('users').doc(freelancer.id).set(freelancer.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
