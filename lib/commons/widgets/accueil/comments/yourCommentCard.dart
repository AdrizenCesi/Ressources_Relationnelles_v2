import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

yourComment(double w, String content, String dateCreation, imgProfil) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: w*0.07,
                backgroundImage: NetworkImage(imgProfil),
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
                bottomRight: Radius.circular(10)
              )
            ),
        child: Column(
          children: [
            Card(
          color: Colors.transparent,
          elevation: 0,
          child: 
                  Text(content, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: w*0.045),)
        ),
        SizedBox(height: 10,),
        Text(dateCreation, style: TextStyle(color: brownLight),)
          ],
        )
        
      ),
            ],
          )
        ],
      ),);
}