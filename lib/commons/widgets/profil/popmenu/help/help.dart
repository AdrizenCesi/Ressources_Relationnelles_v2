import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

class Help extends StatefulWidget {
  Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
        title: Text('Help',),
      ),
      body: ListView(
        children: [
          Card(
            color: brownLight,
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.present_to_all),
              title: Text('Présentation de l\'application'),
            ),
          ),

          Card(
            color: brownLight,
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.all_inbox),
              title: Text('Espace d\'assistance'),
            ),
          ),

          Card(
            color: brownLight,
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.report_problem_outlined),
              title: Text('Signaler un problème'),
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