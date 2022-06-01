import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/groupes/chat/myMessage.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/groupes/chat/yourMessage.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/chat/membres.dart';

// ignore: camel_case_types
class Messages extends StatefulWidget {
  final String idGroupe;
  final String nameGroupe;
  Color _colorContainer1 = brown;
  Color _colorContainer2 = Color(0xffaefea01);

  Messages({Key? key, required this.idGroupe, required this.nameGroupe})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

// ignore: camel_case_types
class _MessagesState extends State<Messages> {
  var myControllerTitle = TextEditingController();
  var myUserId = FirebaseAuth.instance.currentUser!.uid;
  var test;
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: brownLight,
      bottomSheet: Container(
        width: double.infinity,
        height: 85,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(1),
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
                child: txtEditingCont('test', 1),
              ),
            ),
            IconButton(
                onPressed: () {
                  var myData = {
                    'idUser': myUserId,
                    'content': myControllerTitle.text,
                    'dateCreation': DateTime.now(),
                  };
                  var collection = FirebaseFirestore.instance
                      .collection('groupes')
                      .doc(widget.idGroupe)
                      .collection('messages');
                  collection
                      .add(myData) // <-- Your data
                      .then((_) => print('Added'))
                      .catchError((error) => print('Add failed: $error'));
                  myControllerTitle.clear();
                  setState(() {});
                },
                icon: Icon(
                  Icons.send_sharp,
                  color: brown,
                ))
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: brown,
        elevation: 0,
        title: Text(
          widget.nameGroupe,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: () {
                 Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Membres(uId: FirebaseAuth.instance.currentUser!.uid)));
              },
              icon: Icon(Icons.group))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('groupes')
            .doc(widget.idGroupe)
            .collection('messages')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Il y a eu une erreur");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          final data = snapshot.requireData;

          // Première Listview builder : création d'une page scrollable
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:
                  // Seconde Listview builder : création d'une liste de post en correspondance avec la collection post dans firestore
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        profil(data.docs[index]["idUser"]);
                        if (data.docs[index]['idUser'] == myUserId) {
                          return myMessage(
                              wi,
                              data.docs[index]['content'],
                              test['imgProfil'].toString(),
                              convertDateTimeDisplay(data.docs[index]
                                      ['dateCreation']
                                  .toDate()
                                  .toString()));
                        } else {
                          return yourMessage(
                              wi,
                              data.docs[index]['content'],
                              test['firstname'] + ' ' + test['name'],
                              test['imgProfil'],
                              convertDateTimeDisplay(data.docs[index]
                                      ['dateCreation']
                                  .toDate()
                                  .toString()));
                        }
                      }),
            ),
          );
        },
      ),
    );
  }

  txtEditingCont(String label, int max) {
    return Column(
      children: [
        const SizedBox(height: 1),
        TextField(
          controller: myControllerTitle,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          maxLines: max,
        ),
      ],
    );
  }

  profil(profil) async {
    test =
        await FirebaseFirestore.instance.collection('users').doc(profil).get();
  }
}
