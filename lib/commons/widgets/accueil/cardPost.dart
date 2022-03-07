import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/components/addGroup/addGroup.dart';
import 'package:ressources_relationnelles_v1/pages/components/comments/comment.dart';

postCard(context, double w, double h, double heI, title, author, content, datePost, pageComment) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
    children: [
      Container(
        height: h*0.45,
        width: w*1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: brown,
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
                  title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(author),
                  
                ),


                ListBody(
                  children: [
                    Text(content),
                    Container(
                      width: double.infinity,
                      height: heI*0.2,
                      child: Image.asset('images/ressources_relationnelles_transparent.png', fit: BoxFit.cover,),
                    ),
                    Text(datePost, style: TextStyle(color: Colors.grey[500]),),
                    SizedBox(height: 5,),
                    Container(
                      height: 1, 
                      width: double.infinity,
                      color: turquoise.withOpacity(0.4),
                    ),
                    
                    
                  ],
                ),

                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pageComment));
                            },
                            icon: Icon(
                              Icons.add_comment_outlined,
                              color: turquoise,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddGroup()));
                            },
                            icon: Icon(
                              Icons.ios_share_outlined,
                              color: turquoise,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border,
                              color: turquoise,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              color: turquoise,
                            )),
                          
                      ],
                    )
              ],
            )),
      )
    ],
  ),);
}
