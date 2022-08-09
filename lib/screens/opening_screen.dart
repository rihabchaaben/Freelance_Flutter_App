import 'package:flutter/material.dart';
import 'package:freelance_dxb/screens/logIn/log_in.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'package:freelance_dxb/style/style.dart';
import 'package:freelance_dxb/style/text.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  State<OpeningScreen> createState() => _HomePageState();
}

class _HomePageState extends State<OpeningScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                welcomeTitle,
                style: titleStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 60.0,
                  bottom: 40.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: Text(
                  welcomeDescription,
                  style: descriptionStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                'assets/images/welcome-image.png',
              ),
              const SizedBox(
                height: 60.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SignIn();
                  }));
                },
                style: startBtnStyle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 80.0,
                  ),
                  child: Text(
                    start,
                    style: startBtnTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
