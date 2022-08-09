import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:freelance_dxb/repositories/users_repository.dart';
import 'package:freelance_dxb/models/erole.dart';

class LogInCubit extends Cubit<LogInStates> {
  UserRepository userRepository = new UserRepository();

  LogInCubit() : super(logInInitialState());
  static LogInCubit get(context) => BlocProvider.of(context);
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
  }

  postLogIn({
    required String email,
    required String password,
  }) {
    emit(LogInLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      print(value.user!.uid + email + password);

      String id = value.user!.uid;
      UserModel? user = await userRepository.getUserData(
          uid: FirebaseAuth.instance.currentUser!.uid);
      emit(LogInSuccessState(role: RoleExtension.fromString((user?.role)!)));
    }).catchError((e) {
      emit(LogInErrorState('Login or password incorrect'));
    });
  }
}
