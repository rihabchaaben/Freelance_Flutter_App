import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/models/category_model.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:freelance_dxb/cubit/signUp/cubit/signup_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/repositories/categories_repository.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  bool isHint = true;
  IconData icon = Icons.remove_red_eye_outlined;

  changeHintText() {
    isHint = !isHint;
    icon =
        isHint ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
    emit(ChangeHintTextState());
  }

  void postRegister({
    required String name,
    required String phone,
    required String adress,
    required String sessionPrice,
    required String hourPrice,
    String? subcategory,
    required String role,
    required String email,
    String image = "",
    // String cover =
    //"https://image.freepik.com/free-photo/top-view-chopping-board-with-delicious-kebab-lemon_23-2148685530.jpg",
    String bio = "Write yor bio ...",
    required String password,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      getUserData(
          email: email,
          password: password,
          phone: phone,
          uid: value.user!.uid,
          name: name,
          isVerified: value.user!.emailVerified,
          bio: bio,
          role: role,
          hourPrice: hourPrice,
          sessionPrice: sessionPrice,
          // cover: cover,
          adress: adress,
          image: image);
      emit(SignUpSuccessState());
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
      print(error);
    });
  }

  void postRegisterCustomer({
    required String name,
    required String phone,
    required String adress,
    required String role,
    required String email,
    String? sessionPrice,
    String? hourPrice,
    String image = "",
    // String cover =
    //"https://image.freepik.com/free-photo/top-view-chopping-board-with-delicious-kebab-lemon_23-2148685530.jpg",
    String bio = "Write yor bio ...",
    required String password,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      getUserData(
          email: email,
          password: password,
          phone: phone,
          uid: value.user!.uid,
          name: name,
          isVerified: value.user!.emailVerified,
          role: role,
          adress: adress,
          hourPrice: hourPrice,
          sessionPrice: sessionPrice,
          image: image);
      emit(SignUpSuccessState());
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
      print(error);
    });
  }

  void getUserData({
    required String name,
    required String phone,
    required String email,
    required String image,
    // required String cover,
    String? bio,
    required bool isVerified,
    required String password,
    required String uid,
    required String adress,
    required String role,
    String? sessionPrice,
    String? hourPrice,
  }) {
    emit(UserLoadingState());
    UserModel model = UserModel(
        name: name,
        phone: phone,
        email: email,
        adress: adress,
        role: role,
        isVerified: isVerified,
        password: password,
        bio: bio,
        image: image,
        uid: uid);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(UserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(UserErrorState(e.toString()));
    });
  }

  late List<Category> categories;
  Category? category;
/** 
  Future? getAllCategories() {
    emit(GetAllCategoriesLoading());
    categories = [];
    CategoriesRepository().getCategoriesList().then((value) {
      for (var element in value.docs) {
        element.reference.get().then((value) {
          if (category?.id != element.data()['uid'])
            categories.add(Category.fromMap(element.data()));
          print(value.data());
        }).whenComplete(() {
          emit(GetAllCategoriesSucess(categories));
        });
      }
      ;
    }).catchError((error) {
      emit(GetAllCategoriesError());
    });
  }*/
}
