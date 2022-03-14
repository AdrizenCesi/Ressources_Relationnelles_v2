import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/dashboard/dashboard.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/help/help.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/settings/settings.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/friends.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/postsSaved.dart';
import 'package:ressources_relationnelles_v1/pages/components/follows/follows.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';
import '../../../pages/Profil/profil.dart';

Widget headerProfil(BuildContext context, name, firstname, bio, String imgProfil, wi, nPosts, buttonFollow) {
  final AuthenticationService _auth = AuthenticationService();
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: wi*0.15,
            backgroundImage: NetworkImage(imgProfil),),
          
          
        ],
      ),

      // NAME AND FIRSTNAME
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
        alignment: MainAxisAlignment.center,
        children: [
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
                Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Friends()));
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
