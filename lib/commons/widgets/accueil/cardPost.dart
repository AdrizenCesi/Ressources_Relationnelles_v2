import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

cardPost() {
  return Container(
    height: 420,
    child: Card(
      color: brownLight,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: brownDark,),
                    title: const Text('Titre du post'),
                    subtitle: Text(
                      'Auteur du post',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Container(color: brownDark, width: double.infinity, height: 200, child: Image.asset('images/ressources_relationnelles_transparent.png', fit: BoxFit.cover,),),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Perform some action
                        },
                        icon: FaIcon(FontAwesomeIcons.shareSquare, color: turquoise,),
                      ),
                      IconButton(
                        onPressed: () {
                          // Perform some action
                        },
                        icon: FaIcon(FontAwesomeIcons.heart, color: turquoise,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
  );
}