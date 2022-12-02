import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/screens/chat/chats.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/customer_model.dart';
import '../../../screens/marketplace/marketplaceUi.dart';
import '../../../screens/settings/settings_screen-customer.dart';
import '../../logIn/logIn_cubit.dart';

part 'customer_profile_state.dart';

class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  final LogInCubit loginCubit;
    late UserModel currentUser;

  CustomerProfileCubit(this.loginCubit) : super(CustomerProfileInitial()) {
     loginCubit.currentUserStream.listen((user) {
      currentUser = user;
    });
  }

  static CustomerProfileCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  CustomerModel? customerModel;
  late int currentIndex = 0;

  List<String> titlesCustomer = ["Chats", "Marketplace", "Profile"];
  final List<Widget> screensCustomer = [
    Chats(),
    MarketplaceFreelancers(),
    SettingsCustomer(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(changeIndexState());
  }

  UserModel? getUserData({uid}) {
    emit(getUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromMap(value.data());
      emit(getUserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(getUserErrorState(e.toString()));
    });
    return userModel;
  }

  File? profileImage;
  final picker = ImagePicker();
  void uploadprofile({
    required String name,
    required String phone,
    required String password,
    required String email,
    required String adress,
  }) {
    emit(uploadProfileImagePickerLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersImages/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      print(value.ref.getDownloadURL());
      value.ref.getDownloadURL().then((value) {
        updateUser(
            name: name,
            phone: phone,
            password: password,
            email: email,
            adress: adress,
            image: value);
        emit(uploadProfileImagePickerSuccessState());
      }).catchError((e) {
        emit(uploadCoverImagePickerErrorState());
      });
    }).catchError((e) {
      emit(uploadProfileImagePickerErrorState());
    });
  }

  File? coverImage;

  void uploadCover({
    required String name,
    required String phone,
    required String password,
    required String email,
    required String adress,
  }) {
    emit(uploadCoverImagePickerLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersImages/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      print(value.ref.getDownloadURL());
      value.ref.getDownloadURL().then((value) {
        updateUser(
            name: name,
            phone: phone,
            password: password,
            email: email,
            adress: adress,
            cover: value);
        emit(uploadCoverImagePickerSuccessState());
      }).catchError((e) {
        emit(uploadCoverImagePickerErrorState());
      });
    }).catchError((e) {
      emit(uploadCoverImagePickerErrorState());
    });
  }

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(getProfileImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(getProfileImagePickerErrorState());
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String password,
    required String adress,
    cover,
    image,
    email,
    uid,
  
  }) {
    emit(uploadUserLoadingState());
    CustomerModel model = CustomerModel(
      name: name,
      phone: phone,
      adress: adress,
      password: password,
      role: "customer",
      image: image ?? userModel!.image,
      email: email ?? userModel!.email,
      uid: uid ?? userModel!.uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      emit(updateUploadDataUser());
    }).catchError((e) {
      print(e.toString());
      emit(uploadUserErrorState());
    });
  }

  void updateCustomer({
    required String name,
    required String phone,
    required String password,
    required String adress,
    cover,
    image,
    email,
    uid,
  
  }) {
    emit(uploadUserLoadingState());
    CustomerModel model = CustomerModel(
      name: name,
      phone: phone,
      adress: adress,
      password: password,
      role: "customer",
      //  cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      email: email ?? userModel!.email,
      uid: uid ?? userModel!.uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
          customerModel=model;
      emit(updateUploadDataUser());
    }).catchError((e) {
      print(e.toString());
      emit(uploadUserErrorState());
    });
  }
}
