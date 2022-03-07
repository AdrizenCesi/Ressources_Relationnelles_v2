import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/help/help.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/settings/settings.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/postsSaved.dart';
import 'package:ressources_relationnelles_v1/pages/components/follows/follows.dart';

headerProfil(BuildContext context, menu, name, firstname, bio) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: turquoise.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(1, 1), 
              ),
            ], color: turquoise, borderRadius: BorderRadius.circular(10)),
          ),
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
                  'Follow',
                  style: TextStyle(fontSize: 15),
                )),
          ),
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
                '12',
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
                      MaterialPageRoute(builder: (context) => MyTabbedPage()));
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
