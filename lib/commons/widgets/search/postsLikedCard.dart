import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

postsLikedCard(context, double w, double h, double heI) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
    children: [
      Container(
        height: h*0.45,
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
                  trailing: Column(
                    children: [
                      Text('13', style: TextStyle(color:turquoise, fontSize: h*0.02),),
                      Icon(Icons.favorite, color: turquoise,)
                    ],
                  ),
                  
                ),


                ListBody(
                  children: [
                    Text('Learn the skills & get the Job...'),
                    Container(
                      width: double.infinity,
                      height: heI*0.2,
                      child: Image.asset('images/ressources_relationnelles_transparent.png', fit: BoxFit.cover,),
                    ),
                    Text('publish at 12/03/2022', style: TextStyle(color: Colors.grey[500]),),
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
