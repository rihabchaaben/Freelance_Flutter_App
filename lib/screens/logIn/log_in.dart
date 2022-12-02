import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freelance_dxb/models/erole.dart';
import 'package:freelance_dxb/screens/auth/signUpGo.dart';
import 'package:freelance_dxb/screens/layout/home_layout.dart';
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
          body: SingleChildScrollView(
            child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  mainAxisSize: MainAxisSize.max,
                  children: [
              const SizedBox(
                height: 30.0,
              ),
              Text(
                welcomeTitle,
                style: titleStyle,
              ),

              // ignore: prefer_const_constructors
SizedBox(height: 30,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '  Sign In',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
SizedBox(height: 20,),
              Align(
             alignment: Alignment.bottomLeft,

                child: Text(
                  '  Hi there ! Nice to see you again ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
SizedBox(height: 20,),
               
                   
                        
                         Form(
                            key: formKey,
                            child: SizedBox(
                              height: 400,
                              width: 400,
                              child: Expanded(
                                child: Column(
                                  // ignore: prefer_const_constructors
                                                crossAxisAlignment: CrossAxisAlignment.start,  
                                                mainAxisSize: MainAxisSize.max,
                                                          
                                  children: [
                                    buildEmailInput(),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    buildPasswordInput(),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                     MaterialButton(
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            LogInCubit.get(context).postLogIn(
                                                email: emailController.text,
                                                password: passwordController.text);
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
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                        ),
                                      ),
                                       SizedBox(
                                      height: 20
                                    ),
                                     Align(
                                      alignment: Alignment.topCenter,
                                       child: Text(
                                        'Or use one of your profiles',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 107, 105, 105),
                                        ),
                                                                     ),
                                     ),
                                        SizedBox(
                                      height: 20
                                    ),
                                    buildBottomSocialMedia(),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Center(
                                      child: Row(
                                        children: [
                                         Text(
                                                "     Don't have an account?",
                                                style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color:
                                                      Color.fromARGB(255, 107, 105, 105),
                                                ),
                                              ),
                                        
                                                                     
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
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      
                 
                  ],
                ),
          
           
          ),
        ),
        listener: (context, state) {
          if (state is LogInSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            CacheHelper.saveData(key: "isSigned", value: true);
            if (state.role == ERole.admin) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            } else if (state.role == ERole.freelancer) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeLayout()));
            } else if (state.role == ERole.customer) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeLayoutCustomer()));
            }
          }

          if (state is LogInErrorState) {
            toast(Colors.red, state.error, context);
          }
        },
      ),
    );
  }

  buildEmailInput() {
   
    return Expanded(
      flex: 2,
      child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter Email";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 240, 67, 67),
              fontSize: 18,
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
       
      ),
    );
  }

  buildPasswordInput() {
    return Expanded(
      flex: 2,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter Password";
          }
          return null;
        },
        onChanged: (value) {
          password = value;
        },
        onSaved: (val) => password = val!,
        style: const TextStyle(
          fontSize: 16,
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
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  buildBottomSocialMedia() {
    return  Row(
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
                  //signInWithFacebook();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                }),
          ],
        );
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
