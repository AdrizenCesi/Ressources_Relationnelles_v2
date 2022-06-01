
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';

class CustomSearchDelegate extends SearchDelegate {

  CollectionReference _firebaseFirestore =
    FirebaseFirestore.instance.collection('users');
  
  @override 
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: Icon(Icons.clear))
    ];
  }

   @override 
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back_ios));
  }

   @override 
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseFirestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if(!snapshot.hasData) {
            return Text(('Loading...'));
          }
          else{
            if (snapshot.data!.docs.where(
                  (QueryDocumentSnapshot<Object?> elements) => elements['firstname']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase())).isEmpty){
                      return Center(child: Text('Rien de trouvé :('),);
                    }
          }
            return ListView(
              children: [
                ...snapshot.data!.docs.where(
                  (QueryDocumentSnapshot<Object?> element) => element['firstname']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?> data) {

                        final String name = data.get('name');
                        final String firstname = data.get('firstname');
                        final String image = data.get('imgProfil');
                        final String bio = data.get('bio');
                        final String uId = data.get('imgProfil');

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: GestureDetector(
                              onTap: () {Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  appBar: AppBar(
                                                    leading: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }, 
                                                      icon: Icon(Icons.arrow_back_ios))
                                                  ),
                                                  body: Profil(uId: uId ),
                                                  )
                                                  ));},
                              child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                          backgroundImage: NetworkImage(image),
                                        ),
                                          title: Text(name + ' ' + firstname,
                                              style: TextStyle(
                                                color: brown, 
                                                fontWeight: FontWeight.bold,),),
                                          subtitle: Text(
                                            bio,
                                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),));
                    })
              ],
            );
      });
  }

   @override 
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseFirestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if(!snapshot.hasData) {
            return Text('Loading...');
          }
          else{
            if (snapshot.data!.docs.where(
                  (QueryDocumentSnapshot<Object?> element) => element['firstname']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase())).isEmpty){
                      return Center(child: Text('Reessayer plus tard !'),);
                    }
          }
            return ListView(
              children: [
                ...snapshot.data!.docs.map((QueryDocumentSnapshot<Object?> data) {

                        final String name = data.get('name');
                        final String firstname = data.get('firstname');
                        final String bio = data.get('bio');
                        final String image = data.get('imgProfil');

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: GestureDetector(
                              onTap: () {
                                },
                              child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                          backgroundImage: NetworkImage(image),
                                        ),
                                          title: Text(name +' '+ firstname,
                                              style: TextStyle(
                                                color: brown, 
                                                fontWeight: FontWeight.bold,),),
                                          subtitle: Text(
                                            bio,
                                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),));
                    })
              ],
            );
      });
  }
}

