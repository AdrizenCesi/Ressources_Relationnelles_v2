import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/bodyProfil.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/headerProfil.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/myFavoritePostsCard.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/anonym.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/dashboard/dashboard.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/help/help.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/settings/settings.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

class Profil extends StatefulWidget {
  final String? uId;
  Profil({Key? key, required this.uId}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> with TickerProviderStateMixin {
  var userData = {};
  var postData = {};
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
    getPostL();
  }

  int postsLen = 0;

  getPostL() async {
    var postsSnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('content', isNotEqualTo: '')
        .get();

    postsLen = postsSnap.docs.length;
    setState(() {});
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

      var friendsSnap1 = await FirebaseFirestore.instance
          .collection('friendship')
          .where('idUser1', isEqualTo: widget.uId)
          .where('idUser2', isEqualTo: currentUserId)
          .get();

      var friendsSnap2 = await FirebaseFirestore.instance
          .collection('friendship')
          .where('idUser2', isEqualTo: widget.uId)
          .where('idUser1', isEqualTo: currentUserId)
          .get();

      userData = userSnap.data()!;
      postLen = postSnap.docs.length;
      if (friendsSnap1.size != 0 || friendsSnap2.size != 0) {
        isFriends = true;
      }
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
        backgroundColor: secondaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
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
                            Text('Param??tres')
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
                            Text('Se d??connecter')
                          ]))
                    ],
                  ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: 
            userData['name'] == null

            //PROFIL ANONYME
            ? anonymProfil(he, wi)

            //PROFIL CONNECTE
            : Column(
              children: [
                headerProfil(
                  context,
                  userData['name'].toString(),
                  userData['firstname'].toString(),
                  userData['bio'].toString(),
                  userData['imgProfil'].toString(),
                  wi,
                  postsLen.toString(),
                  currentUserId == widget.uId || isFriends == true
                      ? Text('Amis')
                      : SizedBox(
                          width: 160,
                          height: 30,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          turquoise),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () async {
                                var myData = {
                                  'idUser1': currentUserId,
                                  'idUser2': widget.uId,
                                  'validation': true,
                                };
                                var collection = FirebaseFirestore.instance
                                    .collection('friendship');
                                collection
                                    .add(myData) // <-- Your data
                                    .then((_) => print('Added'))
                                    .catchError(
                                        (error) => print('Add failed: $error'));
                              },
                              child: Text(
                                'Follow',
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                ),

                //TAB CONTROLLER 
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
                              color: tab1 ? Colors.white : accentColor),
                          child: Text('My Posts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: tab1
                                      ? accentColor
                                      : Colors.white)),
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
                              color: tab2 ? Colors.white : accentColor),
                          child: Text(
                            'My favorites Posts',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    tab2 ? accentColor : Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),


                tab1
                    //FIRST TAB
                    ? Column(
                        children: [
                          myFavPostsCard(context, wi, he, he),
                          myFavPostsCard(context, wi, he, he),
                          myFavPostsCard(context, wi, he, he),
                          myFavPostsCard(context, wi, he, he)
                        ],
                      )
                    //SECOND TAB
                    :  Column(
                      children: [
                       bodyProfil(context, wi, he, he, userData['auteur'].toString(), userData['title'].toString(), userData['content'].toString(), userData['imgPost'].toString()) 
                        
                      ],
                    ) 
              ]
            )
          ),
        ));
  }
}
