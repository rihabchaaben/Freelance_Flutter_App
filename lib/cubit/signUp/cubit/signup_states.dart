import 'package:equatable/equatable.dart';
import 'package:freelance_dxb/models/category_model.dart';

abstract class SignUpStates extends Equatable {}

class SignUpInitialState extends SignUpStates {
  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends SignUpStates {
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignUpStates {
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpStates {
  List<Object?> get props => [];

  late String error;
  SignUpErrorState(this.error);
}

class ChangeHintTextState extends SignUpStates {
  List<Object?> get props => [];
}

class UserLoadingState extends SignUpStates {
  List<Object?> get props => [];
}

class UserSuccessState extends SignUpStates {
  List<Object?> get props => [];
}

class UserErrorState extends SignUpStates {
  late String error;
  List<Object?> get props => [];

  UserErrorState(this.error);
}

class GetAllCategoriesLoading extends SignUpStates {
  List<Object?> get props => [];
}

class GetAllCategoriesSucess extends SignUpStates {
  final List<Category> categories;

  GetAllCategoriesSucess(this.categories);

  List<Object?> get props => [];
}

class GetAllCategoriesError extends SignUpStates {
  List<Object?> get props => [];
}
