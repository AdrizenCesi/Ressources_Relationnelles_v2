import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/bodyProfil.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/headerProfil.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> with TickerProviderStateMixin {
   bool tab1 = false;
   bool tab2 = true;

  void toggleView() {
    setState(() {
      tab1 = !tab1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
   
    var tabColorActive = brown;
    return Scaffold(
      backgroundColor: brownDark,
      body : SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20), 
        child: Column(
          children: [
            headerProfil(),
           
           Container(
             height: 25, 
             width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5), 
               color: brown,
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               GestureDetector(
                 onTap: () {
                   setState(() {
                     tab1 = !tab1;
                     tab2 = !tab2;
                   });
                 },
                 child: Container(
                 height: 20, 
                 width: 170, 
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   color: tab1 ? brown : brownDark
                 ),
                 child: Text('My Posts', textAlign: TextAlign.center, style: TextStyle(color: tab1 ? Colors.grey[500] : Colors.grey[700])),
               ),
               ),

               GestureDetector(
                 onTap: () {
                   setState(() {
                     tab2 = !tab2;
                     tab1 = !tab1;
                   });
                 },
                 child: Container(
                 height: 20, 
                 width: 170, 
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   color: tab2 ? brown : brownDark
                 ),
                 child: Text('My favorites Posts', textAlign: TextAlign.center, style: TextStyle(color: tab2 ? Colors.grey[500] : Colors.grey[700]),),
               ),
               )
             ],
           ),
           ),

           SizedBox(height: 20,),

            tab1 
            ? Text('tab2')
            : bodyProfil(context, wi*0.9, he*0.4, he*0.2)
          ],
        ),),
      )
    );
  }
}