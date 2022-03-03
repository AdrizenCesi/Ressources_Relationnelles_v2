import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

cardGroupe() {
    return Container(
      height: 100,
    child: Card(
      color: brownLight,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      height: 50, 
                      width: 50,
                      color: turquoise,
                    ),
                    title: const Text('Titre du post'),
                    subtitle: Text(
                      'Auteur du post',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
  );
}