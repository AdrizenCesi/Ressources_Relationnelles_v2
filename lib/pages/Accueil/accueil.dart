import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/cardPost.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brownLight,
      body :  Center(child: cardPost(),),
    );
  }
}