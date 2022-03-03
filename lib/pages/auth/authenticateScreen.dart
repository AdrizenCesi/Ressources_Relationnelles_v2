import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/home/homeScreen.dart';
import 'package:ressources_relationnelles_v1/services/authentication.dart';

class AuthenticateScreen extends StatefulWidget {
  AuthenticateScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final cName = TextEditingController();
  final cFirstname = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  bool showSignIn = true;
  bool obscureText = false;

  @override
  void dispose(){
    cName.dispose();
    cFirstname.dispose();
    cEmail.dispose();
    cPassword.dispose();
    
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error='';
      cName.text = '';
      cFirstname.text = '';
      cEmail.text = '';
      cPassword.text = '';
      showSignIn = !showSignIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              turquoise,
              brownDark,
            ],
          )),
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body:  SingleChildScrollView(
        child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  SizedBox(height: he*0.2,),

                  Text(
                    showSignIn
                    ? 'Se connecter'
                    : 'S\'inscrire',
                    style: new TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient),
                  ),

                  SizedBox(height: 20,),

                  Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showSignIn
                      ? Container()
                      : CircleAvatar(
                        radius: wi * 0.17,
                        backgroundColor: brown.withOpacity(0.3),
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white.withOpacity(0.5),
                          size: wi * 0.15,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      showSignIn
                      ? Container()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: wi * 0.4,
                            child: TextFormField(
                              controller: cName,
                              decoration: textInputDecoration.copyWith(
                                hintText: 'nom',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            width: wi * 0.4,
                            child: TextFormField(
                              controller: cFirstname,
                              decoration: textInputDecoration.copyWith(
                                hintText: 'prenom',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextFormField(
                          controller: cEmail,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'email',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextFormField(
                          controller: cPassword,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'mot de passe',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      GestureDetector(
                        onTap: () {toggleView();},
                        child: Text(
                          showSignIn
                          ? 'Créer un compte'
                          : 'Connectez-vous'
                        ),
                      ),


                      
                      SizedBox(
                        width: wi * 1,
                        height: he * 0.05,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        brown.withOpacity(0.1)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: () async {

                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomeScreen()));
                              
                            },
                            child: Text(showSignIn
                            ? 'Se connecter'
                            : 'S\'inscrire',
                              style: TextStyle(fontSize: wi * 0.05),
                            )),
                      ),

                      SizedBox(height: 10,),

                      showSignIn 
                      ? SizedBox(
                        width: wi * 1,
                        height: he * 0.05,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        brown.withOpacity(0.1)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: () async {
                              
                            },
                            child: Text(
                              'Se connecter en Anonyme',
                              style: TextStyle(fontSize: wi * 0.05),
                            )),
                      )
                      : Container()
                    ],
                  )),
                ],
              )),
          ),
      )
    );
  }
}
