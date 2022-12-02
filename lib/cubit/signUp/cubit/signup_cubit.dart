import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/models/category_model.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:freelance_dxb/cubit/signUp/cubit/signup_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/customer_model.dart';

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
     String? sessionPrice,
     String? hourPrice,
    required List<String> subcategory,
    required String role,
    required String email,
    String image = "",
    rate="0.0",
    String bio = "Write yor bio ...",
    required String password,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      getUserData(
        rate:rate,
          email: email,
          password: password,
          phone: phone,
          uid: value.user!.uid,
          name: name,
          bio: bio,
          role: role,
          hourPrice: hourPrice,
          sessionPrice: sessionPrice,
          adress: adress,
          image: image,
          subcategory: subcategory);
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
    String image = "",
    required String password,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      getCustomerData(
          email: email,
          password: password,
          phone: phone,
          uid: value.user!.uid,
          name: name,
          role: role,
          adress: adress,
          image: image);
      emit(SignUpSuccessState());
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
      print(error);
    });
  }

  void getUserData({
    required List<String> subcategory,
    required String name,
    required String phone,
    required String email,
    required String image,
    String? rate,
    String? bio,
    required String password,
    required String uid,
    required String adress,
    required String role,
    String? sessionPrice,
    String? hourPrice,
  }) {
    emit(UserLoadingState());
    UserModel model = UserModel(
      rate:rate,
      hourPrice: hourPrice,
      sessionPrice: sessionPrice,
        name: name,
        phone: phone,
        email: email,
        adress: adress,
        role: role,
        password: password,
        bio: bio,
        image: image,
        uid: uid,
         subcategory:subcategory);
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

  Future<void> getAllCategories() async {
    final categoriesSnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    final result = categoriesSnapshot.docs.map((currentData) {
      final data = currentData.data();
      return Category.fromMap(data);
    }).toList();
    emit(GetAllCategoriesSucess(result));
  }

  void getCustomerData(
      {required String email,
      required String password,
      required String phone,
      required String uid,
      required String name,
      required String role,
      required String adress,
      required String image}) {
    emit(UserLoadingState());
    CustomerModel model = CustomerModel(
        name: name,
        phone: phone,
        email: email,
        adress: adress,
        role: role,
        password: password,
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

}
