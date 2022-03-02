import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/auth/authenticateScreen.dart';

import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ressources Relationnelles',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily),
      home: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              turquoise,
              brownDark,
            ],
          )),
            child:AuthenticateScreen())
    );
  }
}