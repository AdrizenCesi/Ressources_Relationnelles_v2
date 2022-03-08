import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/comments/myCommentCard.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/comments/yourCommentCard.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';

// ignore: camel_case_types
class Comment extends StatefulWidget {
  final usersRef = FirebaseFirestore.instance.collection('users');
  final String idPost;
  final String titlePost;
  final String? uId;

  Comment(
      {Key? key,
      required this.idPost,
      required this.titlePost,
      required this.uId})
      : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

// ignore: camel_case_types
class _CommentState extends State<Comment> {
  final AuthenticationService _auth = AuthenticationService();
  final Stream<QuerySnapshot> comments =
      FirebaseFirestore.instance.collection('comments').snapshots();
  var myControllerTitle = TextEditingController();
  var myUserId = FirebaseAuth.instance.currentUser!.uid;
  var userData = {};

  getDataUser() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();
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
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: brown,
      appBar: AppBar(
        backgroundColor: brownDark,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios)),
        title : Text(widget.titlePost),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: comments,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("Il y a eu une erreur");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }
              final data = snapshot.requireData;

              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    // Seconde Listview builder : création d'une liste de post en correspondance avec la collection post dans firestore
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          if (widget.idPost == data.docs[index]['idPost']) {
                            return yourComment(wi, '${data.docs[index]['content']}', '${convertDateTimeDisplay(data.docs[index]['dateCreation'].toDate().toString())}');
                          } else {
                            return Container();
                          }
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ),),
      bottomSheet:
      Container(
        width: wi*1,
        height: wi*0.15,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: brownLight,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: brownDark.withOpacity(1),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                child: txtEditingCont(1),
              ),
            ),
            IconButton(
                onPressed: () {
                  var myData = {
                    'idUser': myUserId,
                    'idPost': widget.idPost,
                    'content': myControllerTitle.text,
                    'dateCreation': DateTime.now(),
                  };
                  myControllerTitle.clear();
                  var collection =
                      FirebaseFirestore.instance.collection('comments');
                  collection
                      .add(myData) // <-- Your data
                      .then((_) => print('Added'))
                      .catchError((error) => print('Add failed: $error'));
                  setState(() {});
                },
                icon: Icon(
                  Icons.send_sharp,
                  color: brownDark,
                ))
          ],
        ),
      ),
    );
  }

  txtEditingCont(int max) {
    return 
        TextField(
          controller: myControllerTitle,
          decoration: InputDecoration(
            label: Text('Entrez votre commentaire...'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          maxLines: max,
    );
  }
}