import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  //hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  focusColor: Colors.white,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: const BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
  ),
);
