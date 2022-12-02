import 'package:equatable/equatable.dart';
import 'package:freelance_dxb/models/category_model.dart';

abstract class SignUpStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpStates {
  List<Category?> get props => [];

  late String error;
  SignUpErrorState(this.error);
}

class UserLoadingState extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class UserSuccessState extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class UserErrorState extends SignUpStates {
  late String error;
  List<Category?> get props => [];

  UserErrorState(this.error);
}

class GetAllCategoriesLoading extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class GetAllCategoriesSucess extends SignUpStates {
  GetAllCategoriesSucess(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class GetAllCategoriesError extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class ChangeHintTextState extends SignUpStates {
  @override
  List<Object?> get props => [];
}
