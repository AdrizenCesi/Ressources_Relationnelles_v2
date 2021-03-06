import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

class CommentsList extends StatefulWidget {
  CommentsList({Key? key}) : super(key: key);

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('comments').snapshots();

  var myUserId = FirebaseAuth.instance.currentUser!.uid;

  List<String> allComments = [];

  getData() async {
    List<String> temp = [];

    await FirebaseFirestore.instance.collection('comments').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {allComments.add(doc.id)},
            )
          },
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: brownDark,
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
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, i) {
                        return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(children: <Widget>[
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.size,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        // Cr??ation de la card avec l'ensemble du contenu
                                        child: Card(
                                            elevation: 15,
                                            margin: EdgeInsets.all(5),
                                            shadowColor: brownDark,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Column(children: [
                                              ListTile(
                                                // IconButton profil disponible sur chaque post : renvoie au profil du r??dacteur

                                                title: Text(
                                                  '${data.docs[index]['content']}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    'Supprimer ce post ?'),
                                                                content:
                                                                    new Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Voulez-vous vraiment supprimer ce commentaire ?",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'Fermer')),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        CollectionReference
                                                                            posts =
                                                                            FirebaseFirestore.instance.collection('comments');
                                                                        posts
                                                                            .doc(data.docs[index].id)
                                                                            .delete();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'Supprimer'))
                                                                ],
                                                              ));
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ])));
                                  })
                            ]));
                      });
                }),
          );
        });
  }
}
