import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/home/homeScreen.dart';

class AuthenticateScreen extends StatefulWidget {
  AuthenticateScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  SizedBox(height: he*0.2,),

                  Text(
                    'S\'inscrire',
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
                      CircleAvatar(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: wi * 0.4,
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                hintText: 'nom',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            width: wi * 0.4,
                            child: TextFormField(
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
                          decoration: textInputDecoration.copyWith(
                            hintText: 'mot de passe',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                            onPressed: () {
                              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                            },
                            child: Text(
                              'S\'inscrire',
                              style: TextStyle(fontSize: wi * 0.05),
                            )),
                      )
                    ],
                  )),
                ],
              )),
          )
    );
  }
}
