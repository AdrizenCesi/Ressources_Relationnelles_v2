import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

class Groupes extends StatefulWidget {
  Groupes({Key? key}) : super(key: key);

  @override
  State<Groupes> createState() => _GroupesState();
}

class _GroupesState extends State<Groupes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              turquoise,
              brownDark,
            ],
          )),
          child: Center(child: Text('Groupes'),),
      )
    );
  }
}