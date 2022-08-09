// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freelance_dxb/models/erole.dart';
import 'package:equatable/equatable.dart';

abstract class LogInStates extends Equatable {
  @override
// TODO: implement props
  List<Object?> get props => [];
}

class logInInitialState extends LogInStates {}

class LogInLoadingState extends LogInStates {}

class LogInSuccessState extends LogInStates {
  ERole role;
  LogInSuccessState({
    required this.role,
  });
  @override
  List<Object?> get props => [role];
}

class LogInErrorState extends LogInStates {
  late String error;
  LogInErrorState(this.error);
}
