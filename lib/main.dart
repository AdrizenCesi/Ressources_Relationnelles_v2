

import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/models/user.dart';
import 'package:ressources_relationnelles_v1/pages/auth/authenticateScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ressources_relationnelles_v1/pages/home/homeScreen.dart';
import 'package:ressources_relationnelles_v1/pages/wrapper.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        home: Wrapper(),
    );
  }
  
}
