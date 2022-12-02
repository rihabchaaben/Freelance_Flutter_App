import 'package:equatable/equatable.dart';
import 'package:freelance_dxb/models/chat_model.dart';
import 'package:freelance_dxb/models/message_model.dart';
import 'package:freelance_dxb/models/user_model.dart';

import '../../models/category_model.dart';

abstract class HomeStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeStates {}

class getUserLoadingState extends HomeStates {}

class getUserSuccessState extends HomeStates {}

class getUserErrorState extends HomeStates {
  late String error;
  getUserErrorState(this.error);
}

class changeIndexState extends HomeStates {}
class ChatMessagesSucessState extends HomeStates{
  final List<ChatModel> chatMessages;
    ChatMessagesSucessState(this.chatMessages);

  @override
  List<Object?> get props => [chatMessages];

}

class getProfileImagePickerSuccessState extends HomeStates {}

class getProfileImagePickerErrorState extends HomeStates {}

class getCoverImagePickerSuccessState extends HomeStates {}

class getCoverImagePickerErrorState extends HomeStates {}

class UploadCvLoadingState extends HomeStates {}

class UploadCvSuccessState extends HomeStates {}

class UploadCvErrorState extends HomeStates {}

class uploadProfileImagePickerLoadingState extends HomeStates {}

class uploadProfileImagePickerSuccessState extends HomeStates {}

class uploadProfileImagePickerErrorState extends HomeStates {}

class uploadUserErrorState extends HomeStates {}

class uploadUserLoadingState extends HomeStates {}

class updateUploadDataUser extends HomeStates {}

class getAllUsersLoadingState extends HomeStates {}

class getAllUsersSuccessState extends HomeStates {
  final List<UserModel> users;

  getAllUsersSuccessState(this.users);
  @override
  List<Object?> get props => [users];
}

class getAllUsersErrorState extends HomeStates {}

class sendMessageSuccessState extends HomeStates {}

class sendMessageErrorState extends HomeStates {}

class sendMessagetoRecieverSuccessState extends HomeStates {}

class sendMessagetoRecieverErrorState extends HomeStates {}

class getMessagesSuccessState extends HomeStates {
  final List<MessageModel> messages;

  getMessagesSuccessState(this.messages);

  @override
  List<Object?> get props => [messages];
}
class GetAllCategoriesSucessEdit extends HomeStates {
  GetAllCategoriesSucessEdit(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}
