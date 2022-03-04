import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

yourMessage(double w) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: w*0.12,
                width: w*0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: brownDark,
                  boxShadow: [
                    BoxShadow(
                      color: brownDark,
                      spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(1, 1)
                       )
                  ]
                ),
              ),

            SizedBox(width: 10,),

              Container(
            width: w*0.6,
            decoration: BoxDecoration(
              boxShadow: [
                    BoxShadow(
                      color: brownDark,
                      spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(1, 1)
                       )
                  ],
              color: brownDark.withOpacity(0.6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)
              )
            ),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: 
                  Text('Salut, oui et toi ?', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
        ),
      ),
            ],
          )
        ],
      ),);
}