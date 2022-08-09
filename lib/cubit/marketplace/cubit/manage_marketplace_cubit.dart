import 'package:freelance_dxb/repositories/marketplace_repository.dart';

import '../../../models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'manage_marketplace_state.dart';

class ManageMarketplaceCubit extends Cubit<ManageMarketplaceState> {
  ManageMarketplaceCubit(this.repository) : super(ManageMarketplaceInitial()) {
    getAllFreelancers();
  }

  UserModel? userModel;
  late List<UserModel> freelancers;

  final MarketplaceRepository repository;

  Future? getAllFreelancers() {
    emit(GetAllFreelancersLoading());
    freelancers = [];
    MarketplaceRepository().getFreelancers().then((value) {
      for (var element in value.docs) {
        element.reference.get().then((value) {
          if (userModel?.uid != element.data()['uid'])
            freelancers.add(UserModel.fromJson(element.data()));
          print(value.data());
        }).whenComplete(() {
          emit(GetAllFreelancersSucess(freelancers));
        });
      }
      ;
    }).catchError((error) {
      emit(GetAllFreelancersError());
    });
  }
}
