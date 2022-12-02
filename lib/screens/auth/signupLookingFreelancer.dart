import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:freelance_dxb/screens/layout/home_layout_customer.dart';
// ignore: unused_import
import 'package:freelance_dxb/style/text.dart';
// ignore: unused_import
import 'package:group_radio_button/group_radio_button.dart';
import 'package:freelance_dxb/cubit/signUp/cubit/signup_cubit.dart';
import 'package:freelance_dxb/cubit/signUp/cubit/signup_states.dart';
import 'package:freelance_dxb/shared/components/components.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freelance_dxb/style/style.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../logIn/log_in.dart';

class SignUpLooking extends StatefulWidget {
  const SignUpLooking({Key? key}) : super(key: key);

  @override
  State<SignUpLooking> createState() => _SignUpLookingState();
}

class _SignUpLookingState extends State<SignUpLooking> {
  late Text _errorMessage;
  late String _password;

  //final Role role = Role(id: 3, name: 'customer');
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final TextEditingController _fAdressController;
  late final TextEditingController _phoneController;
  // late final TextEditingController _imageController;
  // late final TextEditingController _rolesController;

  bool isCreating = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _fAdressController = TextEditingController();
    // _imageController = TextEditingController();
    //_rolesController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  bool _obscureText = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  String _singleValue = "Text alignment right";

  bool isChecked = false;
  String? _dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        builder: (context, state) => Scaffold(
            backgroundColor: bgColor,
            body: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 70.0,
                          bottom: 2.0,
                          left: 0.0,
                          right: 300.0,
                        ),
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromARGB(255, 5, 5, 5),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        //  padding: const EdgeInsets.fromLTRB(20, 10, 300, 0),
                        child: Column(children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.95,
                              width: MediaQuery.of(context).size.width,
                              color: bgColor,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 20.0,
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        // Add TextFormFields and ElevatedButton here.
                                        buildUsernameInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        buildAdressInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        buildUserPhoneInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        buildEmailInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        buildPasswordInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),

                                        const SizedBox(
                                          height: 10.0,
                                        ),

                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: CheckboxListTile(
                                            activeColor: Color.fromARGB(
                                                255, 240, 67, 67),
                                            checkColor: Colors.white,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: RichText(
                                              text: TextSpan(
                                                text: 'I agree to the ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'the terms of services ',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 240, 67, 67),
                                                        fontSize: 18,
                                                      )),
                                                  TextSpan(
                                                      text: 'and ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      )),
                                                  TextSpan(
                                                      text: 'privacy policy ',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 240, 67, 67),
                                                        fontSize: 18,
                                                      )),
                                                ],
                                              ),
                                            ),

                                            value: timeDilation != 1.0,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                timeDilation =
                                                    value! ? 10.0 : 1.0;
                                              });
                                            },
                                            //  secondary: const Icon(Icons.hourglass_empty),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10.0,
                                        ),

                                        ElevatedButton(
                                            style: startBtnStyle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 80.0,
                                              ),
                                              child: Text(
                                                'Sign Up',
                                                style: startBtnTextStyle,
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate())
                                                SignUpCubit.get(context)
                                                    .postRegisterCustomer(
                                                  name:
                                                      _usernameController.text,
                                                  phone: _phoneController.text,
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text,
                                                  adress:
                                                      _fAdressController.text,
                                                  role: "customer",
                                                );
                                              // role: ERole.cusupdatomer.name

                                              setState(() {
                                                isCreating = true;
                                              });
                                            }),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        buildBottomMessage(),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ]),
                      ),
                    ])))),
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            toast(Colors.green, "Succeded", context);
          }
          if (state is SignUpErrorState) {
            toast(Colors.red, state.error, context);
          }
          if (state is UserSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeLayoutCustomer()));
          }
        },
      ),
    );
  }

  buildEmailInput() {
    return TextFormField(
      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter your email';
                                        }
                                        return null;
                                      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Please enter your email',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
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
      controller: _emailController,
      onChanged: (val) {},
      style: const TextStyle(),
    );
  }

  buildUsernameInput() {
    return TextFormField(
      controller: _usernameController,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        fillColor: Colors.white,
        labelText: 'Fullname',
        hintText: 'Please enter your fullname',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
 buildUserPhoneInput() {
   //phoneInput.text="32123131";
    return IntlPhoneField(
      controller: _phoneController,
                  decoration: const InputDecoration(
        hintText: 'Please enter your phone Number',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        fillColor: Colors.white,
        labelText: 'Phone Number',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
                  onChanged: (phone) {
                   // print(phone.completeNumber);
                    _phoneController.text=phone.number;
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                );
  }
 
  buildAdressInput() {
    return TextFormField(
      controller: _fAdressController,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your adress';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        hintText: 'Please enter your adress',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        fillColor: Colors.white,
        labelText: 'Adress',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      onSaved: (val) => _password = val!,
      obscureText: _obscureText,
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
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildBottomMessage() {
    return RichText(
      text: TextSpan(
        text: (" have an account ?    "),

        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          color: Color.fromARGB(255, 99, 96, 96),
        ),

        // ignore: prefer_const_constructors

        children: <TextSpan>[
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              fontSize: 23,
                fontFamily: 'Montserrat',
                //fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 240, 67, 67)),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(
                    () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return  SignIn();
                      }));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
