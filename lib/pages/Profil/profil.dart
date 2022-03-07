import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/bodyProfil.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/headerProfil.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/myFavoritePostsCard.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/help/help.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/settings/settings.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
class Profil extends StatefulWidget {
  final String? uId;
  Profil({Key? key, required this.uId}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> with TickerProviderStateMixin {

  var userData = {};
  int postLen = 0;
  bool isLoading = false;
  bool isFriends = false;
  var _iconColorShare = Colors.grey;
  var _iconColorAdd = Colors.grey;
  bool isLiked = false;
  List<String> array = [];
  var collectionLikes = FirebaseFirestore.instance.collection('likes');

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uId)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('idUser', isEqualTo: widget.uId)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(BuildContext context, String text) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(text),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  final AuthenticationService _auth = AuthenticationService();
   bool tab1 = false;
   bool tab2 = true;

  void toggleView() {
    setState(() {
      tab1 = !tab1;
    });
  }
  String _value = "";

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
   
    var tabColorActive = brown;
    return Scaffold(
      backgroundColor: brownLight,
      body : SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20), 
        child: Column(
          children: [
            headerProfil(context, PopupMenuButton(
              color: brownLight,
            icon: Icon(
              Icons.settings,
              color: Colors.grey[500],
            ),
            onSelected: (choice) {
              switch (choice) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Help()));
                  break;
                case 1:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Help()));
                  break;
                case 2:
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          Help()));
                  
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
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
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.help,
                          color: turquoise,
                        )),
                    Text('Aide')
                  ])),
                  PopupMenuItem(
                  value: 2,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
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
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.logout,
                          color: turquoise,
                        )),
                    Text('Se déconnecter')
                  ]))
            ],
          ), userData['name'].toString(), userData['firstname'].toString(), userData['bio'].toString()),
           
           Container(
             height: 25, 
             width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5), 
               color: Colors.white,
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               GestureDetector(
                 onTap: () {
                   setState(() {
                     tab1 = !tab1;
                     tab2 = !tab2;
                   });
                 },
                 child: Container(
                 height: 20, 
                 width: 170, 
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   color: tab1 ? Colors.white : brownLight
                 ),
                 child: Text('My Posts', textAlign: TextAlign.center, style: TextStyle(color: tab1 ? Colors.grey[500] : Colors.grey[700])),
               ),
               ),

               GestureDetector(
                 onTap: () {
                   setState(() {
                     tab2 = !tab2;
                     tab1 = !tab1;
                   });
                 },
                 child: Container(
                 height: 20, 
                 width: 170, 
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   color: tab2 ? Colors.white : brownLight
                 ),
                 child: Text('My favorites Posts', textAlign: TextAlign.center, style: TextStyle(color: tab2 ? Colors.grey[500] : Colors.grey[700]),),
               ),
               )
             ],
           ),
           ),

           SizedBox(height: 20,),

            tab1 
            ? Column(
              children: [
                myFavPostsCard(context, wi, he, he),
                myFavPostsCard(context, wi, he, he),
                myFavPostsCard(context, wi, he, he),
                myFavPostsCard(context, wi, he, he)
              ],
            )
            : Column(
              children: [
                bodyProfil(context, wi, he, he),
                bodyProfil(context, wi, he, he),
                bodyProfil(context, wi, he, he)
              ],
            )
          ],
        ),),
      )
    );
  }
}