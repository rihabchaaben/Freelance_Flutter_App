import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/models/message_model.dart';
import 'package:freelance_dxb/models/subcategory_model.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_dxb/screens/chat/chats.dart';
import 'package:freelance_dxb/screens/offer/fetch_offers.dart';

import 'package:freelance_dxb/screens/settings/settings_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  UserModel? getUserData({uid}) {
    emit(getUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(getUserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(getUserErrorState(e.toString()));
    });
    return userModel;
  }

  late int currentIndex = 0;
  List<String> titles = ["Chats", "Offers", "Profile"];
  List<Widget> screens = [
    Chats(),
    DisplayOffers(),
    Setings(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(changeIndexState());
  }

  File? profileImage;
  final picker = ImagePicker();

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

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(getCoverImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(getCoverImagePickerErrorState());
    }
  }

  void uploadprofile({
    required String name,
    required String phone,
    required String bio,
    required String adress,
    required String password,
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
            bio: bio,
            adress: adress,
            password: password,
            image: value);
        emit(uploadProfileImagePickerSuccessState());
      }).catchError((e) {
        emit(uploadCoverImagePickerErrorState());
      });
    }).catchError((e) {
      emit(uploadProfileImagePickerErrorState());
    });
  }

  void uploadCover({
    required String name,
    required String phone,
    required String bio,
    required String adress,
    required String password,
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
            bio: bio,
            adress: adress,
            password: password,
            cover: value);
        emit(uploadCoverImagePickerSuccessState());
      }).catchError((e) {
        emit(uploadCoverImagePickerErrorState());
      });
    }).catchError((e) {
      emit(uploadCoverImagePickerErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    required String password,
    required String adress,
    cover,
    image,
    email,
    uid,
    isVerified,r
  }) {
    emit(uploadUserLoadingState());
    UserModel model = UserModel(
      role: "freelancer",
      name: name,
      phone: phone,
      bio: bio,
      adress: adress,
      password: password,
      //  cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      email: email ?? userModel!.email,
      uid: uid ?? userModel!.uid,
      isVerified: isVerified ?? userModel!.isVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      emit(updateUploadDataUser());
      getUserData(uid: userModel!.uid);
    }).catchError((e) {
      print(e.toString());
      emit(uploadUserErrorState());
    });
  }

  late List<UserModel> users;

  Future? getAllUsers() {
    emit(getAllUsersLoadingState());
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        element.reference.get().then((value) {
          if (userModel!.uid != element.data()['uid'])
            users.add(UserModel.fromJson(element.data()));
          print(value.data());
        }).whenComplete(() {
          emit(getAllUsersSuccessState());
        });
      }
      ;
    }).catchError((error) {
      emit(getAllUsersErrorState());
    });
  }

  MessageModel? messageModel;
  void sendMessage({
    required String text,
    required String recieverId,
    required String date,
  }) {
    messageModel = MessageModel(
        date: date,
        text: text,
        recieverId: recieverId,
        senderId: userModel!.uid);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(messageModel!.toMap())
        .then((value) {
      emit(sendMessageSuccessState());
    }).catchError((error) {
      emit(sendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(messageModel!.toMap())
        .then((value) {
      emit(sendMessagetoRecieverSuccessState());
    }).catchError((error) {
      emit(sendMessagetoRecieverErrorState());
    });
  }

  List<MessageModel>? messagesList;
  getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messagesList = [];
      event.docs.forEach((e) {
        messagesList!.add(MessageModel.fromJson(e.data()));
        print(e.data());
      });

      emit(getMessagesSuccessState());
    });
  }

  List<SubCategoryModel>? subcategoriesList;
  getSubcategories({required String idcat}) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(idcat)
        .collection('subcategories')
        .snapshots()
        .listen((event) {
      subcategoriesList = [];
      event.docs.forEach((e) {
        subcategoriesList!.add(SubCategoryModel.fromJson(e.data()));
        print(e.data());
      });

      // emit(getMessagesSuccessState());
    });
  }
}
