import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/chat/chatScreen.dart';

cardGroupe(double h, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
                    BoxShadow(
                        color: brown.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(1, 1)),
                  ]
    ),
    height: h,
    child: Card(
      color: brownLight,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: turquoise,
                  boxShadow: [
                    BoxShadow(
                        color: turquoise.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(1, 1)),
                  ]),
            ),
            title: const Text('Flutt\'iZ'),
            subtitle: Text(
              'Adrien, Loic, Baptiste, Anthony,...',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
              onPressed: () {
                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ChatScreen()));
              },
            ),
          ),
        ],
      ),
    ),
  );
}
