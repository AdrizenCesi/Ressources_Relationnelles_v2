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
        backgroundColor: brown,
        body: Container(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Center(
            child:
                // FORM REGISTER OR LOGIN
                Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    showSignIn ? 'Se connecter' : 'S\'inscrire',
                    style: TextStyle(
                        fontSize: wi * 0.1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                            backgroundColor: brownDark.withOpacity(0.3),
                            radius: wi * 0.2,
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: wi * 0.2,
                              color: brownLight,
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
                                    labelStyle: TextStyle(color: Colors.white)),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Enter a name"
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
                                    labelStyle: TextStyle(color: Colors.white)),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Enter a name"
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
                        labelText: 'email',
                        labelStyle: TextStyle(color: Colors.white)),
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter an email"
                        : null,
                  ),
                  SizedBox(height: 10.0),

                  //PASSWORD
                  TextFormField(
                    controller: passwordController,
                    decoration: textInputDecoration.copyWith(
                        labelText: 'password',
                        labelStyle: TextStyle(color: Colors.white)),
                    obscureText: true,
                    validator: (value) => value != null && value.length < 6
                        ? "Enter a password with at least 6 characters"
                        : null,
                  ),

                  //ROLE
                  !showSignIn
                      ? ListTile(
                          title: const Text('Lecteur',
                              style: TextStyle(color: Colors.white)),
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
                            style: TextStyle(color: Colors.white),
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
                          maxLines: 3,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Biographie',
                              labelStyle: TextStyle(color: Colors.white)),
                        )
                      : Container(),

                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: toggleView,
                    child: Text(
                        showSignIn
                            ? 'Créer un compte'
                            : 'Déjà un compte ? Connectez-vous !',
                        style: TextStyle(color: Colors.grey)),
                  ),

                  SizedBox(height: 20.0),

                  //BUTTON REGISTER OR LOGIN

                  SizedBox(
                    width: wi * 0.6,
                    height: he * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.white,
                        textStyle: TextStyle(
                            fontSize: wi * 0.05, fontWeight: FontWeight.bold),
                        primary: brownDark,
                        elevation: 6,
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

                  SizedBox(height: 10.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 15.0),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}

enum Role { lecteur, redacteur }
