import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/chat/message.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';

class bodyGroupes extends StatefulWidget {
  @override
  _bodyGroupes createState() => _bodyGroupes();
}

class _bodyGroupes extends State<bodyGroupes> {
  final Stream<QuerySnapshot> groupes = FirebaseFirestore.instance
      .collection('groupes')
      .where('listId', arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Card(
                        elevation: 15,
                        margin: EdgeInsets.all(5),
                        shadowColor: Color(0xff03989E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
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
                              leading: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profil(
                                              uId: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                            )),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    'images/ressources_relationnelles_transparent.png',
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(10),
                                  primary:
                                      Color(0xff03989E), // <-- Button color
                                  onPrimary: Colors.red, // <-- Splash color
                                ),
                              ),
                              title: Text(
                                '${groupe.docs[index]['groupname']}',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Adrien : " "message",
                                style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                "date : " "heure",
                                style: TextStyle(fontSize: 13.5),
                              ),
                            ),
                          ],
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
