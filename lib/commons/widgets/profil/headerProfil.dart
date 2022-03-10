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
          PopupMenuButton(
                    color: brownLight,
                    icon: Icon(
                      Icons.settings,
                      color: Colors.grey[500],
                    ),
                    onSelected: (choice) {
                      switch (choice) {
                        case 0:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Params()));
                          break;
                        case 1:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Dashboard(uId: FirebaseAuth.instance
                                                      .currentUser!.uid)));
                          break;
                        case 2:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Help()));
                              break;
                        case 3:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Help()));
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 0,
                          child: Row(children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                child: Icon(
                                  Icons.settings,
                                  color: turquoise,
                                )),
                            Text('Paramètres')
                          ])),
                      PopupMenuItem(
                          value: 1,
                          child: Row(children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                child: Icon(
                                  Icons.help,
                                  color: turquoise,
                                )),
                            Text('Aide')
                          ])),
                        PopupMenuItem(
                          value: 1,
                          child: Row(children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                child: Icon(
                                  Icons.help,
                                  color: turquoise,
                                )),
                            Text('Tableau de bord')
                          ])),
                      PopupMenuItem(
                          value: 2,
                          child: Row(children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                child: Icon(
                                  Icons.edit,
                                  color: turquoise,
                                )),
                            Text('Modifier mon profil')
                          ])),
                      PopupMenuItem(
                          onTap: () async {
                            await _auth.signOut();
                          },
                          child: Row(children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                child: Icon(
                                  Icons.logout,
                                  color: turquoise,
                                )),
                            Text('Se déconnecter')
                          ]))
                    ],
                  ),
          
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
