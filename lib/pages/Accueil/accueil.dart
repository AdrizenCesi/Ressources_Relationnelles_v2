import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/cardPost.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/filters.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/bodyProfil.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ressources_relationnelles_v1/pages/Accueil/addPost.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';
import 'package:ressources_relationnelles_v1/pages/components/comments/comment.dart';

class Accueil extends StatefulWidget {
  final String? uId;
  Accueil({Key? key, required this.uId}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  var userData = {};
  var postData = {};
  int postLen = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
    getPostUser();
  }

  getPostUser() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();

      isLoading = true;
    });
    try {
      
      var userId = await FirebaseFirestore.instance
          .collection('posts')
          .doc('idUser')
          .get();

      postData = userId.data()!;
      
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

  getData() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();

      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uId)
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

  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();

  var collectionLikes = FirebaseFirestore.instance.collection('likes');

  bool isLiked = false;

  String dropdownvalue = 'Autre';
  var items = [
    'Football',
    'Sciences',
    'Technologies',
    'M??decine',
    'Politique',
    'Autre'
  ];
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset('images/rl.png', width: wi*0.25,),
          centerTitle: true,
          /*Container(
            width: wi * 0.7,
            child: DropdownButton(
              isExpanded: true,
              value: dropdownvalue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          )*/
          ),
      body: StreamBuilder<QuerySnapshot>(
          stream: posts,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("Il y a eu une erreur");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }
            final data = snapshot.requireData;

            // Premi??re Listview builder : cr??ation d'une page scrollable
            return PlaneIndicator(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, i) {
                      return SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.size,
                                itemBuilder: (context, index) {
                                  return postCard(
                                      context,
                                      wi,
                                      he,
                                      he,
                                      '${data.docs[index]['title']}',
                                      '${data.docs[index]['auteur']}',
                                      '${data.docs[index]['content']}',
                                      '${convertDateTimeDisplay(data.docs[index]['dateCreation'].toDate().toString())}',
                                      Comment(
                                        uId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        idPost: data.docs[index].id,
                                        titlePost: data.docs[index]['title'],
                                      ),
                                      '${data.docs[index]['imgPost']}',
                                      userData['imgProfil'],
                                      Profil(uId: data.docs[index]['idUser']),
                                      IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        onPressed: () {
                                          if (isLiked == true) {
                                            var myData = {
                                              'idPost': data.docs[index]
                                                  ['idPost'],
                                              'idUser': currentUserId
                                            };
                                            collectionLikes
                                                .add(myData)
                                                .then((value) => print('Like'))
                                                .catchError((error) => print(
                                                    'Add failed: $error'));
                                            setState(() {
                                              isLiked = false;
                                            });
                                          } else if (isLiked == false) {
                                            FirebaseFirestore.instance
                                                .collection('likes')
                                                .where('idPost',
                                                    isEqualTo: data.docs[index]
                                                        ['idPost'])
                                                .where('idUser',
                                                    isEqualTo: currentUserId)
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection('likes')
                                                    .doc(element.id)
                                                    .delete()
                                                    .then((value) {
                                                  print('Dislike');
                                                });
                                              });
                                            });
                                            setState(() {
                                              isLiked = true;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.favorite,
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.grey),
                                      ));
                                })
                          ]));
                    }));
          }),
          /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (userData['role'] == 'Role.redacteur')
          ? FloatingActionButton(
              backgroundColor: brownDark,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPostPage(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : Container(),*/
    );
  }
}
