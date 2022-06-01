import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';

class Membres extends StatefulWidget {
  final String? uId;
  Membres({Key? key, required this.uId}) : super(key: key);
  @override
  _Membres createState() => _Membres();
}

class _Membres extends State<Membres> {
  bool isLoading = false;
  var userData = {};
  var groupData = {};

  final Stream<QuerySnapshot> groupes = FirebaseFirestore.instance
      .collection('groupes')
      .where('listId', arrayContains: [0])
      .snapshots();

getData() async {
    setState(() {
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
          .collection('groupes')
          .where('listId', isEqualTo: [1])
          .snapshots();

      
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
                        shadowColor: brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profil(uId: groupe.docs[index]['idUser'])));
                              },
                              title: Text('Profil')
                              
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
