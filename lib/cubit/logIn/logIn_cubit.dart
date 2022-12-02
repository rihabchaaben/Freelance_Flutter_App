import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:freelance_dxb/repositories/users_repository.dart';
import 'package:freelance_dxb/models/erole.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogInCubit extends Cubit<LogInStates> {
  UserRepository userRepository = new UserRepository();
  final _currentUserSubject = new BehaviorSubject<UserModel>();
  StreamSubscription<UserModel>? _userSubstription;

  LogInCubit() : super(logInInitialState());
  static LogInCubit get(context) => BlocProvider.of(context);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("userID"));
    prefs.clear();
  }

  Stream<UserModel> get currentUserStream => _currentUserSubject.stream;

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
      // lets save user with shared prefrences
      await FirebaseMessaging.instance.subscribeToTopic(id);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userID", value.user!.uid);
      print(value.user!.uid);
     _getCurrentFromStore();
    }).catchError((e) {
      emit(LogInErrorState('Login or password incorrect'));
    });
  }

  void loginInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("userID");
    if (token != null) {
      print('Token: $token');
      await FirebaseMessaging.instance.subscribeToTopic(token);
      _getCurrentFromStore();
    } else {
      emit(LogInErrorState('Login or password incorrect'));
    }
  }

  void _getCurrentFromStore() {
    _userSubstription = userRepository
        .getUserData(uid: FirebaseAuth.instance.currentUser!.uid)
        .listen((user) {
      _setCurrentUser(user);
      emit(LogInSuccessState(role: RoleExtension.fromString(user.role)));
    });
  }

  @override
  Future<void> close() {
    _userSubstription?.cancel();
    return super.close();
  }

  void _setCurrentUser(UserModel? user) => _currentUserSubject.add(user!);
}
