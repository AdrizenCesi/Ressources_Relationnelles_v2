import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/cardPost.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/filters.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/bodyProfil.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/refresh.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
   String dropdownvalue = 'Autre';
  var items =  ['Football','Sciences','Technologies','Médecine','Politique','Autre'];
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: brown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.filter_list),
        title:  Container(
          width: wi*0.7,
          child: DropdownButton(
            isExpanded: true,
                value: dropdownvalue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  
                  
                  items:items.map((String items) {
                       return DropdownMenuItem(
                           value: items,
                           child: Text(items)
                       );
                  }
                  ).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
        )
      ),
      body :  PlaneIndicator(
        child:SingleChildScrollView(
        child: Column(
        children: [
         
          postCard(context, wi, he, he),
          postCard(context, wi, he, he),
          postCard(context, wi, he, he)
        ],
      ),
      ),)
    );
  }
}