import 'package:freelance_dxb/screens/auth/signupFreelancer.dart';
import 'package:freelance_dxb/screens/auth/signupLookingFreelancer.dart';
import 'package:freelance_dxb/screens/auth/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'package:freelance_dxb/style/style.dart';
import 'package:freelance_dxb/style/text.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              welcomeTitle,
              style: titleStyle,
            ),
            const SizedBox(
              height: 60.0,
            ),
            Text(
              'Sign up',
              style: signText,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
                bottom: 40.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Text(
                'i want to register as ',
                style: descriptionStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignUpFreelancer();
                }));
              },
              style: startBtnStyle,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 80.0,
                ),
                child: Text(
                  'Freelancer',
                  style: startBtnTextStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignUpLooking();
                }));
              },
              style: startBtnStyle,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 40.0,
                ),
                child: Text(
                  'Looking for Freelancer',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
