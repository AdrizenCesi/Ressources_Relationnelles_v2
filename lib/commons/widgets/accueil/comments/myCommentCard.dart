import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

myComment(double w, String content, imgProfil) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
            width: w*0.6,
            decoration: BoxDecoration(
              boxShadow: [
                    BoxShadow(
                      color: accentColor,
                      spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(1, 1)
                       )
                  ],
              color: accentColor.withOpacity(0.6),
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
                  Text(content, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
        ),
      ),

      SizedBox(width: 10,),

      CircleAvatar(
        radius: w*0.06,
        backgroundImage: NetworkImage(imgProfil),
      )
            ],
          )
        ],
      ),);
}