import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:freelance_dxb/screens/adminstration/dashboard.dart';
import 'package:freelance_dxb/screens/auth/signUpGo.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../style/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_button/sign_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  // ignore: unused_field
  late Text _errorMessage;
  late String email;
  late String password;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool checkedValue = true;
  bool isLoginOpen = false;
  bool isloading = false;
  bool isCreating = false;
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic>? _userData;

  String welcome = "Facebook";
  @override
  void initState() {
    super.initState();
  }

  final formkey = GlobalKey<FormState>();

  // ignore: unnecessary_new

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            key: formkey,
                            child: Column(
                              children: [
                                buildEmailInput(),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                buildPasswordInput(),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                buildLoginButton(),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Or use one of your profiles',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 182, 175, 175),
                                  ),
                                ),
                                buildBottomSocialMedia(),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                buildBottomMessage(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildEmailInput() {
    return TextFormField(
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
            setState(() {
              _obscureText = !_obscureText;
            });
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

  buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 48.0,
        bottom: 28.0,
      ),
      child: ElevatedButton(
        style: startBtnStyle,
        onPressed: () async {
          if (formkey.currentState!.validate()) {
            setState(() {
              isloading = true;
            });
            try {
              await _auth.signInWithEmailAndPassword(
                  email: email, password: password);

              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contex) => Dashboard(),
                ),
              );

              setState(() {
                isloading = false;
              });
            } on FirebaseAuthException catch (e) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Ops! Login Failed"),
                  content: Text('${e.message}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child:  Text('Okay'),
                    )
                  ],
                ),
              );
              print(e);
            }
            setState(() {
              isloading = false;
            });
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 64.0,
          ),
          child: Text(
            'Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 48.0,
        bottom: 28.0,
      ),
      child: ElevatedButton(
        style: startBtnStyle,
        onPressed: () async {
          setState(() {
            isCreating = true;
          });
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 64.0,
          ),
          child: Text(
            'signIn',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
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

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) => Dashboard(),
                    ),
                  );
                }),
          ],
        ));
  }

  buildBottomMessage() {
    return RichText(
      text: TextSpan(
        text: (" forgot password?                             "),

        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Color.fromARGB(255, 182, 175, 175),
        ),

        // ignore: prefer_const_constructors

        children: <TextSpan>[
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
                fontFamily: 'Montserrat',
                //fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 240, 67, 67)),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(
                    () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const Signup();
                      }));
                    },
                  ),
          ),
        ],
      ),
    );
  }

  buildBottomMessagev2() {
    return RichText(
      text: TextSpan(
        text: 'Already have an account?  ',
        style: const TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.white),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(() {
                    isLoginOpen = !isLoginOpen;
                  }),
          ),
        ],
      ),
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

    setState(() {
      welcome = _userData?['email'];
    });

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
