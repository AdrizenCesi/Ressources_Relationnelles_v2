import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/settings/components/personnalInfos.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Params extends StatefulWidget {
  Params({Key? key}) : super(key: key);

  @override
  State<Params> createState() => _ParamsState();
}

class _ParamsState extends State<Params> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: brown,
      appBar: AppBar(
        backgroundColor: brownDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back_ios)),
        title: Text('Settings',),
      ),
      body: ListView(
        children: [
          Card(
            color: brownLight,
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                              MaterialPageRoute(builder: (context) => InfosPerso(uId: FirebaseAuth.instance.currentUser!.uid)));
              },
              leading: Icon(Icons.person),
              title: Text('Informations Personnelles'),
            ),
          ),

          Card(
            color: brownLight,
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.security),
              title: Text('Changez votre mot de passe'),
            ),
          ),

          Card(
            color: brownLight,
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.analytics),
              title: Text('Politiques d\'utilisation des données'),
            ),
          )
        ],
      ),
      bottomSheet: 
      Container(
        color: brown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
            width: wi*0.4,
            color: brown,
            child: 
                Image.asset('images/ressources_relationnelles_transparent.png', )
          )
          ],
        ),
      )
    );
  }
}