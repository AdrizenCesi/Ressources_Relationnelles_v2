import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class InfosPerso extends StatefulWidget {
  final String? uId;
  const InfosPerso({Key? key, required this.uId}) : super(key: key);

  @override
  State<InfosPerso> createState() => _InfosPersoState();
}

class _InfosPersoState extends State<InfosPerso> {
  var userData = {};
  bool isLoading = true;

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

  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: brownDark,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: (userData['name'] == null)
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Vous ??tes un Compte Anonyme !', textAlign: TextAlign.center,),
                          SizedBox(height: 10,),
                          ElevatedButton(
                              onPressed: () async {
                                await _auth.signOut();
                              },
                              child: Text('S\'inscrire')),
                          ElevatedButton(
                              onPressed: () async {
                                await _auth.signOut();
                              },
                              child: Text('Se connecter'))
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        CircleAvatar(
                          radius: wi*0.2,
                          backgroundImage: NetworkImage(userData['imgProfil']),
                        ),
                        SizedBox(height: 20,),
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text('Nom'),
                            subtitle: Text(userData['name']),
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text('Pr??nom'),
                            subtitle: Text(userData['firstname']),
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text('Adresse mail'),
                            subtitle: Text(userData['email']),
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text('R??le'),
                            subtitle: Text(userData['role']),
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text('Biographie'),
                            subtitle: Text(userData['bio']),
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text('Mod??rateur'),
                            subtitle: Text((userData['modo'] == true)
                                ? 'Compte Mod??rateur'
                                : 'Compte Non-Mod??rateur'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text('Administrateur'),
                            subtitle: Text((userData['admin'] == true)
                                ? 'Compte administrateur'
                                : 'Compte Non-Administrateur'),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Text(
                            'Supprimer votre compte ?',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context),
                            );
                          },
                        )
                      ],
                    )),
        ));
  }
}

_buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    backgroundColor: Colors.grey[200],
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    title: const Text(
      'Supprimer votre compte ?',
      style: TextStyle(color: Colors.red),
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "En cliquant sur \'Oui\', vous faites une demande de supression de votre compte !",
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () {
          final Uri _emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'adrienberard@hotmail.fr',
            queryParameters: {
              'subject': "Demande de supression",
              'body': "Je voudrais supprimer mon compte !"
            },
          );
        },
        child: const Text('Oui !'),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Fermer'))
    ],
  );
}
