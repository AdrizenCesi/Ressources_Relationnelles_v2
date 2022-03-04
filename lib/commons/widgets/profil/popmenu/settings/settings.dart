import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
              onTap: () {},
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