import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:freelance_dxb/models/erole.dart';
import 'package:freelance_dxb/repositories/categories_repository.dart';
import 'package:freelance_dxb/screens/auth/start_screen.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:freelance_dxb/screens/layout/home_layout.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'package:freelance_dxb/style/style.dart';
// ignore: unused_import
import 'package:freelance_dxb/style/text.dart';
// ignore: unused_import
import 'package:group_radio_button/group_radio_button.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:freelance_dxb/cubit/signUp/cubit/signup_cubit.dart';
import 'package:freelance_dxb/cubit/signUp/cubit/signup_states.dart';
import 'package:freelance_dxb/shared/components/components.dart';

import '../../models/category_model.dart';
// ignore: import_of_legacy_library_into_null_safe

class SignUpFreelancer extends StatefulWidget {
  const SignUpFreelancer({Key? key}) : super(key: key);

  @override
  State<SignUpFreelancer> createState() => _SignUpFreelancerState();
}

class _SignUpFreelancerState extends State<SignUpFreelancer> {
  // FreelancerModel freelancer;
  late List data;
  bool isCreating = false;
  List<dynamic> _selectedCategories = [];
  late String _mySelection;
  late Text _errorMessage;
  TextEditingController usernameInput = TextEditingController();
  TextEditingController userPasswordInput = TextEditingController();
  TextEditingController adressInput = TextEditingController();
  TextEditingController priceInput = TextEditingController();
  TextEditingController aboutMeInput = TextEditingController();
  TextEditingController phoneInput = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  File? imageFile;
  String? _password;
  bool _obscureText = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "session";
  List<String> _status = ["session", "hour"];

  bool isChecked = false;
  List<Category> categories = [];
  @override
  void initState() {
    categories = CategoriesRepository().getAllCaregories() as List<Category>;
    super.initState();
  }

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
                          top: 30.0,
                          bottom: 2.0,
                          left: 0.0,
                          right: 300.0,
                        ),
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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

                                        buildEmailInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        buildUserPhoneInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        buildPasswordInput(),
                                        const SizedBox(
                                          height: 5.0,
                                        ),

                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              RadioGroup<String>.builder(
                                                direction: Axis.horizontal,
                                                groupValue: _verticalGroupValue,
                                                horizontalAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                onChanged: (value) =>
                                                    setState(() {
                                                  _verticalGroupValue = value!;
                                                }),
                                                items: _status,
                                                textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 240, 67, 67),
                                                ),
                                                itemBuilder: (item) =>
                                                    RadioButtonBuilder(
                                                  item,
                                                ),
                                              ),
                                            ]),
                                        buildPriceInput(),

                                        const SizedBox(
                                          height: 10.0,
                                        ),

                                        Row(
                                          children: [
                                            MultiSelectDialogField(
                                              
                                              items: categories
                                                  .map((e) => MultiSelectItem(
                                                      e, e.designation))
                                                  .toList(),
                                              title: Text("Categories"),
                                              selectedColor: Colors.red,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2,
                                                ),
                                              ),
                                              onConfirm: (results) {
                                                _selectedCategories = results;
                                              },
                                            ),
                                          ],
                                        ),
                                        // value: _dropdownValues.first,

                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        buildaboutMeInput(),
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
                                                    fontSize: 14.0),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'the terms of services ',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 240, 67, 67),
                                                        fontSize: 14,
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
                                                        fontSize: 14,
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
                                        SizedBox(height: 16.0),
                                        isCreating
                                            ? CircularProgressIndicator()
                                            : ElevatedButton(
                                                style: startBtnStyle,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 80.0,
                                                  ),
                                                  child: Text(
                                                    'Sign Up ',
                                                    style: startBtnTextStyle,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                          .validate() &&
                                                      _verticalGroupValue ==
                                                          "session")
                                                    SignUpCubit.get(context)
                                                        .postRegister(
                                                      name: usernameInput.text,
                                                      phone: phoneInput.text,
                                                      email:
                                                          _emailController.text,
                                                      password:
                                                          userPasswordInput
                                                              .text,
                                                      adress: adressInput.text,
                                                      bio: aboutMeInput.text,
                                                      sessionPrice:
                                                          priceInput.text,
                                                      hourPrice: "",
                                                      //  role: ERole
                                                      //   .freelancer
                                                      //   .name
                                                      role: "freelancer",
                                                    );
                                                  else if (_formKey
                                                          .currentState!
                                                          .validate() &&
                                                      _verticalGroupValue ==
                                                          "hour")
                                                    SignUpCubit.get(context)
                                                        .postRegister(
                                                      name: usernameInput.text,
                                                      phone: phoneInput.text,
                                                      role:
                                                          ERole.freelancer.name,
                                                      email:
                                                          _emailController.text,
                                                      password:
                                                          userPasswordInput
                                                              .text,
                                                      adress: adressInput.text,
                                                      bio: aboutMeInput.text,
                                                      sessionPrice: "",
                                                      hourPrice:
                                                          priceInput.text,
                                                    );

                                                  setState(() {
                                                    isCreating = false;
                                                  });
                                                },
                                              ),
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeLayout()));
          }
        },
      ),
    );
  }

  List? statesList;
  String? _myState;

  buildEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Please enter your email',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
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
      controller: _emailController,
      onChanged: (val) {},
      style: const TextStyle(),
    );
  }

  buildUsernameInput() {
    return TextFormField(
      controller: usernameInput,
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
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildUserPhoneInput() {
    return TextFormField(
      controller: phoneInput,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
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
        labelText: 'Phone Number',
        hintText: 'Please enter your Phone number',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildAdressInput() {
    return TextFormField(
      controller: adressInput,
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
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildPasswordInput() {
    return TextFormField(
      controller: userPasswordInput,
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
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildPriceInput() {
    return TextFormField(
      controller: priceInput,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your price';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        hintText: 'Please enter your hour/session price ',
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
        labelText: '',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  final List<String> _dropdownValues = [
    "It Enginner",
    "Front end developper",
    "Three",
    "Four",
    "Five"
  ];

  buildaboutMeInput() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: 1,
      maxLines: 5,
      controller: aboutMeInput,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'about you!';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        hintText: '',
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
        labelText: 'About Me',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
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
          color: Color.fromARGB(255, 182, 175, 175),
        ),

        // ignore: prefer_const_constructors

        children: <TextSpan>[
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
                fontFamily: 'Montserrat',
                //fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 240, 67, 67)),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(
                    () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const StartScreen();
                      }));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
