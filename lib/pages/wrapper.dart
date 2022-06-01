import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/models/user.dart';
import 'package:ressources_relationnelles_v1/pages/auth/authenticateScreen.dart';
import 'package:provider/provider.dart';
import 'package:ressources_relationnelles_v1/pages/home/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthenticateScreen();
    } else {
      return HomeScreen(uId: FirebaseAuth.instance.currentUser!.uid);
    }
  }
}