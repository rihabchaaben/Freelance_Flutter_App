part of 'customer_profile_cubit.dart';

@immutable
abstract class CustomerProfileState {}

class CustomerProfileInitial extends CustomerProfileState {}

class getUserLoadingState extends CustomerProfileState {}

class getUserSuccessState extends CustomerProfileState {}

class getUserErrorState extends CustomerProfileState {
  late String error;
  getUserErrorState(this.error);
}

class changeIndexState extends CustomerProfileState {}

class getProfileImagePickerSuccessState extends CustomerProfileState {}

class getProfileImagePickerErrorState extends CustomerProfileState {}

class getCoverImagePickerSuccessState extends CustomerProfileState {}

class getCoverImagePickerErrorState extends CustomerProfileState {}

class uploadCoverImagePickerLoadingState extends CustomerProfileState {}

class uploadCoverImagePickerSuccessState extends CustomerProfileState {}

class uploadCoverImagePickerErrorState extends CustomerProfileState {}

class uploadProfileImagePickerLoadingState extends CustomerProfileState {}

class uploadProfileImagePickerSuccessState extends CustomerProfileState {}

class uploadProfileImagePickerErrorState extends CustomerProfileState {}

class uploadUserErrorState extends CustomerProfileState {}

class uploadUserLoadingState extends CustomerProfileState {}

class updateUploadDataUser extends CustomerProfileState {}
