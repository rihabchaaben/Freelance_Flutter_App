import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/repositories/marketplace_repository.dart';
import '../../../models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'manage_marketplace_state.dart';

class ManageMarketplaceCubit extends Cubit<ManageMarketplaceState> {
  ManageMarketplaceCubit(this.repository) : super(ManageMarketplaceInitial())  {
      getAllFreelancers();
  }

  UserModel? userModel;
  late List<UserModel> freelancers;
  final MarketplaceRepository repository;
  Future<List<UserModel>> getAllFreelancers() async {
    emit(GetAllFreelancersLoading());
    freelancers = [];
  final freelancersCollection= await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'freelancer')
        .orderBy('rate', descending: true)
        .get();
      freelancers = freelancersCollection.docs.map((currentData) {
        return UserModel.fromMap(currentData.data());
      }).toList();
      emit(GetAllFreelancersSucess(freelancers));
    return freelancers;
  }

}
