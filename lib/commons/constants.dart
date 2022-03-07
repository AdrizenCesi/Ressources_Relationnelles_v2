import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


const turquoise = Color(0xff54BAB9);
const brownDark = Color(0xffC9B38F);
const brown = Color.fromARGB(255, 230, 215, 198);
const brownLight = Color.fromARGB(255, 241, 236, 222);


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

String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}