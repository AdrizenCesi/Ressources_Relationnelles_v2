import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/pages/home/homeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class VerifyEmail extends StatefulWidget {
  VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;

  @override 
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_)=> checkEmailVerified()
      );
    }
  }

  @override 
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {

    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
   ? HomeScreen(uId: FirebaseAuth.instance.currentUser!.uid)
   : Scaffold(
     appBar: AppBar(
       title: Text('Verify your Email'),
     ),
     body: Padding(
       padding: EdgeInsets.all(16),
       child: Column(
         children: [
           Text('Une vérification a été envoyé par mail !')
         ],
       ),),
   );
}