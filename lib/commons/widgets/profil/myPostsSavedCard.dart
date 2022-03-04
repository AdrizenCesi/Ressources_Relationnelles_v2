import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

myPostsSavedCard(context, double w, double h, double heI) {
  return Padding(
    padding: EdgeInsets.only(top: 10, bottom: 10), 
    child: Column(
    children: [
      Container(
        height: h*0.4,
        width: w*1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: brownDark,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: turquoise.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(1, 1),
                          ),
                        ],
                        color: turquoise,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  title: Text('Become a UX Designer', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Anton JR'),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark,
                        color: turquoise,
                      )),
                ),


                ListBody(
                  children: [
                    Text('Learn the skills & get the Job...'),
                    Container(
                      width: double.infinity,
                      height: heI*0.2,
                      child: Image.asset('images/ressources_relationnelles_transparent.png', fit: BoxFit.cover,),
                    ),
                    Container(
                      height: 1, 
                      width: double.infinity,
                      color: turquoise.withOpacity(0.4),
                    )
                    
                  ],
                ),

                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_comment_outlined,
                              color: turquoise,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.ios_share_outlined,
                              color: turquoise,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border,
                              color: turquoise,
                            ))
                      ],
                    )
              ],
            )),
      )
    ],
  ),);
}
