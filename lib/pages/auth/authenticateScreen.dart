import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ressources_relationnelles_v1/services/storage.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final bioController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    nameController.dispose();
    firstnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      nameController.text = '';
      firstnameController.text = '';
      passwordController.text = '';
      bioController.text = '';
      showSignIn = !showSignIn;
    });
  }

  Role _site = Role.lecteur;

//IMAGE
  var _path;
  var _fileName;
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    //SIZE OF MOBILE
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: secondaryColor,
        body: Center(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: 
                // FORM REGISTER OR LOGIN
                Form(
              key: _formKey,
              child: Column(
                children: [
                  showSignIn
                  ? Image.asset('images/rl.png', width: wi*0.5,)
                  : Container(),
                  Text(
                    showSignIn ? 'Se connecter' : 'S\'inscrire',
                    style: TextStyle(
                        fontSize: wi * 0.1,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  !showSignIn
                      ? _path == null
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
                          child: CircleAvatar(
                            backgroundColor: primaryColor.withOpacity(0.6),
                            radius: wi * 0.2,
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: wi * 0.2,
                              color: secondaryColor,
                            ),
                          ))
                          : CircleAvatar(
                            radius: wi*0.2,
                            backgroundImage: FileImage(File(_path)),
                          )
                      : Container(),

                  !showSignIn
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),

                  !showSignIn
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // NAME
                            Container(
                              width: wi * 0.4,
                              child: TextFormField(
                                controller: nameController,
                                decoration: textInputDecoration.copyWith(
                                    labelText: 'Nom',
                                    labelStyle: TextStyle(color: primaryColor)),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Entrez votre nom"
                                        : null,
                              ),
                            ),

                            //FIRSTNAME
                            Container(
                              width: wi * 0.4,
                              child: TextFormField(
                                controller: firstnameController,
                                decoration: textInputDecoration.copyWith(
                                    labelText: 'Prénom',
                                    labelStyle: TextStyle(color: primaryColor)),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Entrez votre prénom"
                                        : null,
                              ),
                            ),
                          ],
                        )
                      : Container(),

                  !showSignIn ? SizedBox(height: 10.0) : Container(),

                  //EMAIL
                  TextFormField(
                    controller: emailController,
                    decoration: textInputDecoration.copyWith(
                        labelText: 'adresse email',
                        labelStyle: TextStyle(color: primaryColor)),
                    validator: (value) => value == null || value.isEmpty
                        ? "Entrez votre adresse email"
                        : null,
                  ),
                  SizedBox(height: 10.0),

                  //PASSWORD
                  TextFormField(
                    controller: passwordController,
                    decoration: textInputDecoration.copyWith(
                        labelText: 'mot de passe',
                        labelStyle: TextStyle(color: primaryColor)),
                    obscureText: true,
                    validator: (value) => value != null && value.length < 6
                        ? "Entrez un mot de passe avec minimum 6 caractères"
                        : null,
                  ),

                  //ROLE
                  !showSignIn
                      ? ListTile(
                          title: const Text('Lecteur',
                              style: TextStyle(color: primaryColor)),
                          leading: Radio(
                            value: Role.lecteur,
                            groupValue: _site,
                            onChanged: (Role? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        )
                      : Container(),
                  !showSignIn
                      ? ListTile(
                          title: const Text(
                            'Rédacteur',
                            style: TextStyle(color: primaryColor),
                          ),
                          leading: Radio(
                            value: Role.redacteur,
                            groupValue: _site,
                            onChanged: (Role? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        )
                      : Container(),

                  //BIOGRAPHIE

                  !showSignIn
                      ? TextFormField(
                          controller: bioController,
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Biographie',
                              labelStyle: TextStyle(color: primaryColor)),
                        )
                      : Container(),

                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: toggleView,
                    child: Text(
                        showSignIn
                            ? 'Créer un compte'
                            : 'Déjà un compte ? Connectez-vous !',
                        style: TextStyle(color: primaryColor, fontSize: wi*0.04, fontWeight: FontWeight.bold)),
                  ),

                  SizedBox(height: 20.0),

                  //BUTTON REGISTER OR LOGIN

                  SizedBox(
                    width: wi * 0.6,
                    height: he * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.brown,
                        textStyle: TextStyle(
                            fontSize: wi * 0.05, fontWeight: FontWeight.bold),
                        primary: accentColor,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      child: Text(
                        showSignIn ? "Se connecter" : "S\'inscrire",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          setState(() => loading = true);
                          var password = passwordController.value.text;
                          var email = emailController.value.text;
                          var name = nameController.value.text;
                          var firstname = firstnameController.value.text;
                          var role = _site.toString();
                          var bio = bioController.value.text;
                          var imgProfil = showSignIn
                          ? ''
                          : await storage.uploadFile(_path, _fileName);
                          bool modo = false;
                          bool admin = false;
                          bool ban = false;
                          dynamic result = showSignIn
                              ? await _auth.signInWithEmailAndPassword(
                                  email, password)
                              : await _auth.registerWithEmailAndPassword(
                                  name,
                                  firstname,
                                  email,
                                  password,
                                  role,
                                  bio,
                                  imgProfil,
                                  modo, 
                                  admin, 
                                  ban);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 15.0),

                  showSignIn
                  ? SizedBox(
                    width: wi * 0.6,
                    height: he * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: wi * 0.04, fontWeight: FontWeight.bold),
                        primary: accentColor,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      child: Text(
                        'Se connecter en Anonyme',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await _auth.signInAnonymously();
                      },
                    ),
                  )
                  : Container(),

                  SizedBox(height: 15.0),

                  showSignIn
                  ? SizedBox(
                    width: wi * 0.6,
                    height: he * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: wi * 0.04, fontWeight: FontWeight.bold),
                        primary: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      child: Text(
                        'Se connecter avec Google',
                        style: TextStyle(color: accentColor),
                      ),
                      onPressed: () async {
                        await _auth.signInAnonymously();
                      },
                    ),
                  )
                  : Container(),

                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

enum Role { lecteur, redacteur }
