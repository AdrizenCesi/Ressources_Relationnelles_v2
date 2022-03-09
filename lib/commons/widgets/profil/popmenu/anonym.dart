import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';

Widget anonymProfil(wi, he) {
  final AuthenticationService _auth = AuthenticationService();
  return Column(
    children: [
      Image.asset('images/ressources_relationnelles_transparent.png'),

      //BUTTON REGISTER
      SizedBox(
        width: wi * 0.3,
        height: he * 0.08,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.brown,
            textStyle:
                TextStyle(fontSize: wi * 0.025, fontWeight: FontWeight.bold),
            primary: turquoise,
            elevation: 3,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          child: Text(
            'S\'inscrire',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),

      SizedBox(height: 20,),

      //BUTTON LOGIN
      SizedBox(
        width: wi * 0.3,
        height: he * 0.08,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.brown,
            textStyle:
                TextStyle(fontSize: wi * 0.025, fontWeight: FontWeight.bold),
            primary: turquoise,
            elevation: 3,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          child: Text(
            'Se connecter',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),
      

    ],
  );
}
