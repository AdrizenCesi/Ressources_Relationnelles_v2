import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

bodyProfil() {
  return Column(
    children: [

      Container(
        height: 200, 
        width: 350, 
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: turquoise,
        ),
        child: Card(
          color: Colors.transparent,
          elevation:0,
          child: Column(
            children: [
              ListTile(
            title: Text('Become a UX Designer'),
            subtitle: Text('Anton JR')
          ),

          ListBody(
            children: [
              Text('Learn the skills & get the Job')
            ],
          )
            ],
          )

        ),
      )
    ],
  );
}