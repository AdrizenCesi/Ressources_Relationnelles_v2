import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/cardPost.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/groupes/cardGroupe.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/refresh.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/bodyGroupe.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/chat/message.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Groupes extends StatefulWidget {
  Groupes({Key? key}) : super(key: key);

  @override
  State<Groupes> createState() => _GroupesState();
}

class _GroupesState extends State<Groupes> {
  final Stream<QuerySnapshot> groupes = FirebaseFirestore.instance
      .collection('groupes')
      .where('listId', arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        leading: Icon(null),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body : StreamBuilder<QuerySnapshot>(
        stream: groupes,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Il y a eu une erreur");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('En chargement');
          }
          final groupe = snapshot.requireData;
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: groupe.size,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      child: Card(
                        color: primaryColor,
                        clipBehavior: Clip.antiAlias,
                        child:
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Messages(
                                          idGroupe: groupe.docs[index].id,
                                          nameGroupe: groupe.docs[index]
                                              ['groupname'])),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(groupe.docs[index]['imgGroup']),
                                radius: wi*0.06,
                              ),
                              title: Text(
                                '${groupe.docs[index]['groupname']}',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                convertDateTimeDisplay(groupe.docs[index]['dateCreation'].toDate().toString()),
                                style: TextStyle(fontSize: 13.5),
                              ),
                            ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}