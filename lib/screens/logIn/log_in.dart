import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freelance_dxb/cubit/home_layout/cubit.dart';
import 'package:freelance_dxb/models/erole.dart';
import 'package:freelance_dxb/screens/auth/signUpGo.dart';
import 'package:freelance_dxb/screens/layout/home_layout.dart';
import 'package:freelance_dxb/models/user_model.dart';
import 'package:freelance_dxb/cubit/login/logIn_cubit.dart';
import 'package:freelance_dxb/cubit/logIn/logIn_states.dart';
import 'package:freelance_dxb/screens/adminstration/dashboard.dart';
import 'package:freelance_dxb/shared/components/components.dart';
import 'package:freelance_dxb/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance_dxb/style/colors.dart';
import '../../style/style.dart';
import '../../style/text.dart';
import 'package:sign_button/sign_button.dart';
import '../../style/colors.dart';
import '../layout/home_layout_customer.dart';

class SignIn extends StatefulWidget {
  String welcome = "Facebook";
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late Text _errorMessage;
  late String email;
  late String password;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool checkedValue = true;
  bool isLoginOpen = false;
  bool isloading = false;
  bool isCreating = false;
  final snackBar = SnackBar(
    content: Text('successed',
        style: TextStyle(
          color: Colors.white,
        )),
    backgroundColor: Colors.grey,
  );
  Map<String, dynamic>? _userData;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInStates>(
        builder: (context, state) => Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            welcomeTitle,
                            style: titleStyle,
                          ),

                          // ignore: prefer_const_constructors
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 10, 150, 0),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 10, 450, 0),
                      child: Column(
                        children: const [
                          Text(
                            'Hi there ! Nice to see you again ',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      //  padding: const EdgeInsets.fromLTRB(20, 10, 300, 0),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.70,
                            width: MediaQuery.of(context).size.width,
                            color: bgColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 40.0,
                                  horizontal: 40.0,
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    // ignore: prefer_const_constructors

                                    children: [
                                      buildEmailInput(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      buildPasswordInput(),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 48.0,
                                          bottom: 28.0,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              LogInCubit.get(context).postLogIn(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);

                                            }

                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: Colors.red,
                                          minWidth: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: state is LogInLoadingState
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    "LogIn",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Or use one of your profiles',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 182, 175, 175),
                                        ),
                                      ),
                                      buildBottomSocialMedia(),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // ignore: prefer_const_constructors
                                          Text(
                                            "Don't have an account?",
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color.fromARGB(
                                                  255, 182, 175, 175),
                                            ),
                                          ),
                                          // ignore: prefer_const_constructors
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Signup()));
                                              },
                                              child: Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        listener: (context, state) {
          if (state is LogInSuccessState) {
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
            CacheHelper.saveData(key: "isSigned", value: true);
            if(state.role==ERole.admin){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Dashboard()));

            }
            else if(state.role==ERole.freelancer){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeLayout()));

            }
            else if(state.role==ERole.customer){
           
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeLayoutCustomer()));
          }}

          if (state is LogInErrorState) {
            toast(Colors.red, state.error, context);
          }
        },
      ),
    );
  }

  buildEmailInput() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter Email";
        }
      },
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
      ),
      style: const TextStyle(),
    );
  }

  buildPasswordInput() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter Password";
        }
      },
      onChanged: (value) {
        password = value;
      },
      onSaved: (val) => password = val!,
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        focusColor: Colors.white,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _obscureText = !_obscureText;
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Color.fromARGB(255, 88, 87, 87),
          ),
        ),
        fillColor: Color.fromARGB(255, 88, 87, 87),
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildBottomSocialMedia() {
    return Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
                buttonType: ButtonType.linkedin,
                btnText: "linkedin",
                width: 125,

                // ignore: prefer_const_constructors
                shape: RoundedRectangleBorder(
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.horizontal()),
                //  width: 100,
                buttonSize: ButtonSize.small, // small(default), medium, large
                onPressed: () {
                  print('click');
                }),
            Text('    '),
            SignInButton(
                buttonType: ButtonType.facebook,
                btnText: "facebook",
                btnColor: Color.fromARGB(255, 21, 78, 124),
                buttonSize: ButtonSize.small,
                shape: RoundedRectangleBorder(
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.horizontal()),
                width: 125,
                // small(default), medium, large
                onPressed: () {
                  signInWithFacebook();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                }),
          ],
        ));
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result =
        await FacebookAuth.instance.login(permissions: ['email']);

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();

      _userData = userData;
    } else {
      print(result.message);
    }

    //  setState(() {
    //  welcome = _userData?['email'];});

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
