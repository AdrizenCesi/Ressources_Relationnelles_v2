import 'package:flutter/material.dart';


const turquoise = Color(0xff54BAB9);
const brownDark = Color(0xffE9DAC1);
const brown = Color(0xffF7ECDE);
const brownLight = Color(0xffFBF8F1);


var textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 40),
  fillColor: Colors.transparent,
  filled: true,
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.circular(40)),
  focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.circular(40)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 2.0),
      borderRadius: BorderRadius.circular(40)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.circular(40)),
);

final Shader linearGradient = LinearGradient(
   colors: <Color>[brownLight, brownDark],
).createShader(
   Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);