import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/home/homeScreen.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

final AuthenticationService _auth = AuthenticationService();
Color _colorContainer1 = brownDark;
Color _colorContainer2 = turquoise;
bool verif = true;

class _AddPostPageState extends State<AddPostPage> {
  String dropdownValue = 'Categorie';
  String lastKey = '';
  String myTitle = '';
  String myContent = '';
  var name = '';
  var prenom = '';
  var currentColor = Color(0xff03989E);
  var myUserId = FirebaseAuth.instance.currentUser!.uid;
  var myControllerTitle = TextEditingController();
  var myControllerContent = TextEditingController();

  List<String> array = [];

  // Categorie possible de post
  Map<String, bool> arrayCateg = {
    'Code': false,
    'Gastronomie': false,
    'Sciences': false,
    'Gaming': false,
    'Sport': false,
    'Film': false,
    'Technologies': false,
  };

  // Charge les données de l'utilisateur courant nécessaire avant de construire le widget
  getData() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {
                if (doc.id == myUserId)
                  if (doc.data()['name'] != null)
                    {
                      name = doc.data()['name'],
                      prenom = doc.data()['firstname'],
                    }
              },
            )
          },
        );
  }

  initarrayCateg() async {
    for (var i = 0; i < array.length; i++) {
      arrayCateg[array[i]] = false;
    }
  }

  // Retourne la list des tags sélectionnés
  List getTags() {
    var myList = [];
    for (var i = 0; i < arrayCateg.length; i++) {
      if (arrayCateg.values.elementAt(i) == true)
        myList.add(arrayCateg.keys.elementAt(i));
    }
    return myList;
  }

  // Verifie le nombre de catégorie qui ont été choisi par user courant
  verifNumberCat() {
    var n = 0;
    for (var i = 0; i < arrayCateg.length; i++) {
      if (arrayCateg.values.elementAt(i) == true) n += 1;
    }
    if (n < 4)
      return true;
    else
      return false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerTitle.dispose();
    myControllerContent.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: brown,
      // Barre verte d'action "Création du nouveau Post"
      appBar: AppBar(
        backgroundColor: brownDark,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),

      // Front de la page AddPostPage
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 32),
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 24),
                  txtEditingCont('Titre', 1),
                  const SizedBox(height: 24),
                  txtEditingCont('Contenu', 10),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                  left: 30,
                  right: 30,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Catégorie(s)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < arrayCateg.length; i++)
                        unitPilCat(arrayCateg, i)
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              //BUTTON POST
              SizedBox(
                width: wi * 0.6,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: brownDark,
                    ),
                    onPressed: () async {
                      var myData = {
                        'idUser': myUserId,
                        'auteur': prenom + ' ' + name,
                        'content': myControllerContent.text,
                        'dateCreation': DateTime.now(),
                        'title': myControllerTitle.text,
                        'tags': getTags(),
                        'idLikeUsers': [],
                        'idPost': DateTime.now().toString() + myUserId
                      };
                      var collection =
                          FirebaseFirestore.instance.collection('posts');
                      collection
                          .add(myData) // <-- Your data
                          .then((_) => print('Added'))
                          .catchError((error) => print('Add failed: $error'));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            uId: FirebaseAuth.instance.currentUser!.uid,
                          ),
                        ),
                      );
                    },
                    child: Text('Publier')),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Create choice categorie for new post
  unitPilCat(Map array, int i) {
    return Material(
      child: InkWell(
        onTap: () {
          // Code to setup only 3 categories choice
          if (verifNumberCat()) {
            setState(() {
              array.values.elementAt(i) == true
                  ? array.update(
                      array.keys.elementAt(i), (value) => value = false)
                  : array.update(
                      array.keys.elementAt(i), (value) => value = true);
              lastKey = array.keys.elementAt(i);
            });
          } else {
            setState(() {
              array.update(lastKey, (value) => value = false);
              array.update(array.keys.elementAt(i), (value) => value = true);
              lastKey = array.keys.elementAt(i);
            });
          }
        },
        // Front button categories
        child: Ink(
          color: brown,
          child: Container(
            margin: const EdgeInsets.only(right: 5, left: 5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  array.values.elementAt(i) == true ? turquoise : brownDark,
                  array.values.elementAt(i) == true ? turquoise : brownDark,
                ],
              ),
            ),
            // Text du nom de la catégorie
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  array.keys.elementAt(i),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Textfield avec controller, pour récupérer les champs
  txtEditingCont(String label, int max) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller:
              label == 'Titre' ? myControllerTitle : myControllerContent,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: max,
        ),
      ],
    );
  }
}
