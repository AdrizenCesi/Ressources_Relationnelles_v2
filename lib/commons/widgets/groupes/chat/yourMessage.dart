import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

yourMessage(double w, contentYourMessage, username, imgProfil, dateMessage) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: w*0.06,
                backgroundImage: NetworkImage(imgProfil) ,
              ),

            SizedBox(width: 10,),

              Column(
                children: [
                  Container(
                    width: w*0.55,
                    child: Text(username, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),),
                  ),
                  SizedBox(height: 7,),

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
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: 
                  Text(contentYourMessage, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
        ),
      ),
      SizedBox(height:7),
      Container(
        width: w*0.55,
        child: Text(dateMessage),
      )
                ],
              )
            ],
          )
        ],
      ),);
}