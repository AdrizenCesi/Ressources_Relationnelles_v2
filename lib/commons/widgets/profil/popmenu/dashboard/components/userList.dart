import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

class UsersList extends StatefulWidget {
  UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('users').snapshots();

  var myUserId = FirebaseAuth.instance.currentUser!.uid;

  List<String> allPosts = [];
  List<Color> allFavPostUser = [];

  getData() async {
    List<String> temp = [];

    await FirebaseFirestore.instance
        .collection('users')
        .where('name', isNull: false)
        .get()
        .then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {allPosts.add(doc.id)},
            )
          },
        );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var banColor = Colors.red;
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation:0,
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
                                                title: Text(
                                                  '${data.docs[index]['firstname']}' +
                                                      ' ' +
                                                      '${data.docs[index]['name']}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: (data.docs[index]
                                                            ['ban'] ==
                                                        true)
                                                    ? Text('Compte D??sactiv??')
                                                    : Text('Compte Actif'),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      (data.docs[index]
                                                                  ['ban'] ==
                                                              false)
                                                          ? showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        'D??sactiver ce compte ?'),
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
                                                                          "Voulez-vous vraiment d??sactiver le compte de : " +
                                                                              '${data.docs[index]['firstname']}' +
                                                                              ' ' +
                                                                              '${data.docs[index]['name']}',
                                                                          style:
                                                                              TextStyle(fontSize: 15),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('Fermer')),
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            final usersRef =
                                                                                FirebaseFirestore.instance.collection('users');
                                                                            usersRef.doc(data.docs[index].id).update({
                                                                              "ban": true
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('D??sactiver'))
                                                                    ],
                                                                  ))
                                                          : showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        'Activer ce compte ?'),
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
                                                                          "Voulez-vous vraiment activer le compte de : " +
                                                                              '${data.docs[index]['prenom']}' +
                                                                              ' ' +
                                                                              '${data.docs[index]['name']}',
                                                                          style:
                                                                              TextStyle(fontSize: 15),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('Fermer')),
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            final usersRef =
                                                                                FirebaseFirestore.instance.collection('users');
                                                                            usersRef.doc(data.docs[index].id).update({
                                                                              "ban": false
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('Activer'))
                                                                    ],
                                                                  ));
                                                    },
                                                    icon: Icon(
                                                      (data.docs[index]
                                                                  ['ban'] ==
                                                              true)
                                                          ? Icons
                                                              .radio_button_checked
                                                          : Icons
                                                              .radio_button_unchecked,
                                                      color: (data.docs[index]
                                                                  ['ban'] ==
                                                              true)
                                                          ? Colors.red
                                                          : Colors.green,
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
