import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/help/help.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/settings/settings.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/postsSaved.dart';

headerProfil(BuildContext context, menu) {
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
      Text(
        'Anton JR.',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      Text(
        'Creative director at @ui8.net \n A designer that keens simplicity and usability ',
        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
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
              Text(
                '26',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
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
