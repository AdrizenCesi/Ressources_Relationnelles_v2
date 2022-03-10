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

List<dynamic> user = [];
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
      user = [];
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
        user.add(temp);
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
      backgroundColor: brown,
        appBar: AppBar(
          backgroundColor: brownDark,
          title: Form(
            key: _formKey,
          child: TextFormField(
            controller: myControllerNomGroupe,
            decoration: textInputDecoration.copyWith(labelText: 'Nom du groupe'),
            validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Entrez le nom du groupe"
                                        : null,
          ),
        ),
        actions: [
          _path == null 
             ? GestureDetector(
                onTap: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.image,
                  );

                  if (results == null) {
                    return null;
                  }

                  final path = results.files.single.path!;
                  _path = path;
                  final fileName = results.files.single.name;
                  _fileName = fileName;
                  setState(() {});
                  print(_path);
                },
                child: Container(
                  width: wi * 0.2,
                  height: wi * 0.18,
                  color: brownDark,
                  child: Icon(Icons.add_a_photo_outlined, size: wi*0.1, color: Colors.white.withOpacity(0.5),),
                ),
              )
              : CircleAvatar(
                radius: wi*0.1,
                backgroundImage: FileImage(File(_path),),
              ),
        ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: 

               //LIST FRIENDS
            ListView.builder(
            itemCount: user.length,
            itemBuilder: (context, index) {
              bool cliquee = false;
              
              return ListTile(
                  onTap: () {
                    if (_formKey.currentState?.validate() == true) {
                      addonlist(user[index].id);
                    
                    }else{
                      return null;
                    }
                    
                  },
                  leading: CircleAvatar(
                    radius: wi*0.07,
                    backgroundImage: NetworkImage(user[index]['imgProfil'])),
                  title: Text(
                    user[index]['firstname'] + ' ' + user[index]['name'],
                    style: TextStyle(
                        fontSize: wi*0.05,
                        color: cliquee ? Colors.white :Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Checkbox(
                    value: value, 
                    onChanged: (value)=> setState(() {
                      this.value = value!;
                    }))
              );
            })
           ,)
        ,bottomNavigationBar: 
        
        SizedBox(
          width: wi*0.4,
          child: ElevatedButton(
          onPressed: () async {
            ajoutGroupe(list, await storage.uploadFile(_path, _fileName));
            Navigator.pop(context);
            myControllerNomGroupe.clear();
          },
          child: const Text('Création'),
        ),
        )
      );
  }
}

void ajoutGroupe(List<String> list, uploadImgGroup) {
  list.add(FirebaseAuth.instance.currentUser!.uid);
  var myData = {
    'groupname': myControllerNomGroupe.text,
    'listId': list,
    'dateCreation': DateTime.now(),
    'imgGroup': uploadImgGroup,
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
