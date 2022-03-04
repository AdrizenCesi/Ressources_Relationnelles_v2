import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/cardPost.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/groupes/cardGroupe.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/refresh.dart';

class Groupes extends StatefulWidget {
  Groupes({Key? key}) : super(key: key);

  @override
  State<Groupes> createState() => _GroupesState();
}

class _GroupesState extends State<Groupes> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: brown,
      appBar: AppBar(
        leading: Icon(null),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body : SingleChildScrollView(
          child: Column(children: [
          cardGroupe(he*0.1, context),
          cardGroupe(he*0.1, context),
          cardGroupe(he*0.1, context),
          cardGroupe(he*0.1, context),
        ],),
        )
    );
  }
}