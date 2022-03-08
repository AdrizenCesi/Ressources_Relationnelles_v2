import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/help/help.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/settings/settings.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/postsSaved.dart';
import 'package:ressources_relationnelles_v1/pages/components/follows/follows.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../pages/Profil/profil.dart';

headerProfil(BuildContext context, menu, name, firstname, bio, String imgProfil, wi, nPosts, buttonFollow) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(imgProfil, fit: BoxFit.cover, height: wi*0.25, width: wi*0.25, ),
            borderRadius: BorderRadius.circular(10)),
          menu
          
        ],
      ),

      // NAME AND FIRSTNAME
      Row(
        children: [
          Text(
        name,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 10,),
      Text(
        firstname,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
        ],
      ),
      Text(
        bio,
        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 18),
      ),
      ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 160,
            height: 30,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(turquoise),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                onPressed: () async {},
                child: Text(
                  'Add Friend',
                  style: TextStyle(fontSize: 15),
                )),
          ),
          buttonFollow
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                'Posts',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                nPosts,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Text('|'),
          Column(
            children: [
              Text('Followers', style: TextStyle(color: Colors.grey[600])),
              GestureDetector(
                child:Text(
                '26',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              onTap: () {

              },
              )
              
            ],
          ),
          Text('|'),
          Column(
            children: [
              Text('Posts Saved', style: TextStyle(color: Colors.grey[600])),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PostsSaved()));
                }, 
                icon: Icon(Icons.bookmark))
            ])
        ],
      )
    ],
  );
}
