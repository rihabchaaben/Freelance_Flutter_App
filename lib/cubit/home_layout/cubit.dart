import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance_dxb/cubit/home_layout/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_cubit.dart';
import 'package:freelance_dxb/models/chat_model.dart';
import 'package:freelance_dxb/models/message_model.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import '../../models/category_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  final LogInCubit loginCubit;
  late UserModel currentUser;
  HomeCubit(this.loginCubit) : super(HomeInitialState()) {
    loginCubit.currentUserStream.listen((user) {
      currentUser = user;
    });
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
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

  File? cv;

  void uploadprofile({
    required String name,
    required String phone,
    required String bio,
    required String adress,
    required String password,
   required String email,
 required List<String>subcategory,
 required String rate,
 String? sessionPrice,
 String? hourPrice,

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
          rate: rate,
          hourPrice: hourPrice,
          sessionPrice: sessionPrice,
          subcategory: subcategory,
            name: name,
            email: email,
            phone: phone,
            bio: bio,
            adress: adress,
            password: password,
            image: value);
        emit(uploadProfileImagePickerSuccessState());
      }).catchError((e) {
        emit(UploadCvErrorState());
      });
    }).catchError((e) {
      emit(uploadProfileImagePickerErrorState());
    });
  }

  void uploadCV({
    required String name,
    required String phone,
    required String bio,
    required String adress,
    required String password,
    required File cv,
    required String email,
    required List<String> subcategory,
    required String rate,
    String? hourPrice,
    String? sessionPrice,

  }) {
    emit(UploadCvLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usersCVFiles/${Uri.file(cv.path).pathSegments.last}')
        .putFile(cv)
        .then((value) {
      print(value.ref.getDownloadURL());
      value.ref.getDownloadURL().then((value) {
        updateUser(
          rate:rate,
         subcategory :  subcategory,
sessionPrice: sessionPrice,
hourPrice :hourPrice,
            name: name,
            phone: phone,
            bio: bio,
            adress: adress,
            password: password,
            email: email,
            cv: value);
        emit(UploadCvSuccessState());
      }).catchError((e) {
        emit(UploadCvErrorState());
      });
    }).catchError((e) {
      emit(UploadCvErrorState());
    });
  }

  void updateUser(
      {required String name,
      required String phone,
      required String bio,
      required String password,
      required String adress,
      required List<String>subcategory,
      required String rate,
      String? hourPrice,
String? sessionPrice,
      cv,
      image,
      email,
      uid,
     }) {
    emit(uploadUserLoadingState());
    UserModel model = UserModel(
      role: "freelancer",
      name: name,
      phone: phone,
      bio: bio,
      adress: adress,
      password: password,
      cv: cv ?? userModel!.cv,
      image: image ?? userModel!.image,
      email: email ?? userModel!.email,
      uid: uid ?? userModel!.uid,
      subcategory: subcategory,
      rate:rate,
      hourPrice: email ?? userModel!.hourPrice,
      sessionPrice: email ?? userModel!.sessionPrice,
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

  Future<void> getAllUsers() async {
    try {
      emit(getAllUsersLoadingState());

      List<UserModel> users = await _getUsers();
      emit(getAllUsersSuccessState(users));
    } catch (e) {
      emit(getAllUsersErrorState());
    }
  }

  Future<List<UserModel>> _getUsers() async {
    final userCollection =
        await FirebaseFirestore.instance.collection('users').get();
    final users = userCollection.docs
        .map((element) => UserModel.fromMap(element.data()))
        .where((user) => FirebaseAuth.instance.currentUser!.uid != user.uid)
        .toList();
    return users;
  }

  Future<void> sendPushMessage(String to, String senderName) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': ' application/json',
          'Authorization':
              'key=AAAAF-TvN5g:APA91bE6nDzeX-UA0oWw6zvyZjR_EctoakdTHX3WSRsNojL4663Rv_6nE7rylC27TiFoz3Aj6vdr0M2AfkEPzkpTCrVKaMP1QOm_lR--JxqT3q962vUXxLvgjCIZAF3CP3tQKdEpnV_6'
        },
        body: jsonEncode({
          'to': '/topics/$to',
          'notification': {
            'title': 'Nouveau message de !',
            'body': ' $senderName',
          },
        }),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  void sendMessage({
    required String text,
    required String recieverId,
    required String date,
  }) {
    final messageModel = MessageModel(
      date: date,
      text: text,
      recieverId: recieverId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      sendPushMessage(recieverId, currentUser.name);
      emit(sendMessageSuccessState());
    }).catchError((error) {
      emit(sendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(sendMessagetoRecieverSuccessState());
    }).catchError((error) {
      emit(sendMessagetoRecieverErrorState());
    });
  }

  getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      final result = event.docs.map((currentData) {
        return MessageModel.fromJson(
            currentData.data(), FirebaseAuth.instance.currentUser!.uid);
      }).toList();

      emit(getMessagesSuccessState(result));
    });
  }

  Future<void> getChatMessages() async {
    try {
      final users = await _getUsers();
      final chatModels = <ChatModel>[];
      await Future.forEach(users, (UserModel user) async {
        final lastMessage = await getLastMessage(receiverId: user.uid);
        if (lastMessage != null) {
          chatModels.add(ChatModel(
            id: user.uid,
            imageUrl: user.image,
            userName: user.name,
            lastMessage: lastMessage.text,
            date: lastMessage.date,
          ));
        }
      });
      emit(ChatMessagesSucessState(chatModels));
    } on Exception catch (e) {
    print("chat error");
    }
  }

  Future<MessageModel?> getLastMessage({required String receiverId}) async {
    final messagesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date', descending: true)
        .get();
    List<MessageModel?> messages = messagesSnapshot.docs.map((currentData) {
      return MessageModel.fromJson(
          currentData.data(), FirebaseAuth.instance.currentUser!.uid);
    }).toList();
    return messages.isEmpty ? null : messages.first;
  }

    Future<void> getAllCategories() async {
    final categoriesSnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    final result = categoriesSnapshot.docs.map((currentData) {
      final data = currentData.data();
      return Category.fromMap(data);
    }).toList();
    emit(GetAllCategoriesSucessEdit(result));
  }
}
