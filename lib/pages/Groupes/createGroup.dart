import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/services/storage.dart';
import 'package:file_picker/file_picker.dart';

class CreationGroupe extends StatefulWidget {
  @override
  _CreationGroupe createState() => _CreationGroupe();
}

List<dynamic> test = [];
List<String> list = [];
var myControllerNomGroupe = TextEditingController();



class _CreationGroupe extends State<CreationGroupe> {
  final _formKey = GlobalKey<FormState>();
  var taille = 0;
  bool isLoading = false;
  late List<String> friendship = [];
  var _iconColor = Colors.grey;
  var _iconColorShare = Colors.grey;
  var _iconColorAdd = Colors.grey;

  

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();

      isLoading = true;
    });
    try {
      test = [];
      var amies1 = await FirebaseFirestore.instance
          .collection('friendship')
          .where('idUser2', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('validation', isEqualTo: true)
          .get();

      var amies2 = await FirebaseFirestore.instance
          .collection('friendship')
          .where('idUser1', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('validation', isEqualTo: true)
          .get();

      for (var i = 0; i < amies1.size; i++) {
        friendship.add(amies1.docs[i]['idUser1']);
      }

      for (var i = 0; i < amies2.size; i++) {
        friendship.add(amies2.docs[i]['idUser2']);
      }

      for (int i = 0; i < friendship.length; i++) {
        var temp = await FirebaseFirestore.instance
            .collection('users')
            .doc(friendship[i])
            .get();
        test.add(temp);
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

  bool value = false;

  var _path;
var _fileName;
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    setState(() {});
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black12,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Title(
            color: Colors.white,
            child: Text(
              'Cr??ation du nouveau groupe',
              style: TextStyle(color: Colors.white, fontSize: 19),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: test.length,
            itemBuilder: (context, index) {
              bool cliquee = true;
              return Container(
                child: ListTile(
                  onTap: () {
                    addonlist(test[index].id);
                    if (cliquee == true)
                      cliquee = false;
                    else
                      cliquee = true;
                  },
                  title: Text(
                    test[index]['name'],
                    style: TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                        backgroundColor: cliquee ? Colors.green : Colors.amber),
                  ),
                ),
              );
            }),
        bottomSheet: TextField(
          controller: myControllerNomGroupe,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
          
          onPressed: () {
            ajoutGroupe(list);
            Navigator.pop(context);
          },
          child: const Text('Cr??ation'),
        ));
  }
}

void ajoutGroupe(List<String> list) {
  list.add(FirebaseAuth.instance.currentUser!.uid);
  var myData = {
    'groupname': myControllerNomGroupe.text,
    'listId': list,
    'dateCreation': DateTime.now(),
    //'imgGroup': uploadImgGroup,
  };
  var collection = FirebaseFirestore.instance.collection('groupes');
  collection
      .add(myData) // <-- Your data
      .then((_) => print('Added'))
      .catchError((error) => print('Add failed: $error'));
}

void addonlist(String id) {
  if (list.contains(id)) {
    list.remove(id);
  } else
    list.add(id);
}
