import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

class Compteurs extends StatefulWidget {
  Compteurs({Key? key}) : super(key: key);

  @override
  State<Compteurs> createState() => _CompteursState();
}

class _CompteursState extends State<Compteurs> {
  var userData = {};
  int usersLen = 0;
  int postsLen = 0;
  int commentsLen = 0;
  int likesLen = 0;
  int groupLen = 0;
  int categoriesLen = 0;
  int modosLen = 0;
  int adminsLen = 0;

  @override
  void initState() {
    super.initState();
    getUserL();
    getPostL();
    getCommentL();
    getLikeL();
    getGroupeL();
    getCategoriesL();
    getModosL();
    getAdminsL();
  }

  getUserL() async {
    var usersSnap = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isNotEqualTo: '')
        .get();

    usersLen = usersSnap.docs.length;
    setState(() {});
  }
  getPostL() async {
    var postsSnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('content', isNotEqualTo: '')
        .get();

    postsLen = postsSnap.docs.length;
    setState(() {});
  }
  getCommentL() async {
    var commentsSnap = await FirebaseFirestore.instance
        .collection('comments')
        .where('content', isNotEqualTo: '')
        .get();

    commentsLen = commentsSnap.docs.length;
    setState(() {});
  }
  getLikeL() async {
    var likesSnap = await FirebaseFirestore.instance
        .collection('likes')
        .where('idUser', isNotEqualTo: '')
        .get();

    likesLen = likesSnap.docs.length;
    setState(() {});
  }
  getGroupeL() async {
    var groupSnap = await FirebaseFirestore.instance
        .collection('groupes')
        .where('groupname', isNotEqualTo: '')
        .get();

    groupLen = groupSnap.docs.length;
    setState(() {});
  }
  getLikesL() async {
    var likesSnap = await FirebaseFirestore.instance
        .collection('likes')
        .where('idUser', isNotEqualTo: '')
        .get();

    likesLen = likesSnap.docs.length;
    setState(() {});
  }
  getCategoriesL() async {
    var categoriesSnap = await FirebaseFirestore.instance
        .collection('categorie')
        .where('list', isNotEqualTo: '')
        .get();

    categoriesLen = categoriesSnap.docs.length;
    setState(() {});
  }
  getModosL() async {
    var modosSnap = await FirebaseFirestore.instance
        .collection('users')
        .where('modo', isNotEqualTo: false)
        .get();

    modosLen = modosSnap.docs.length;
    setState(() {});
  }
  getAdminsL() async {
    var adminsSnap = await FirebaseFirestore.instance
        .collection('users')
        .where('admin', isNotEqualTo: false)
        .get();

    adminsLen = adminsSnap.docs.length;
    setState(() {});
  }
 

  @override
  Widget build(BuildContext context) {
    double uL = usersLen.toDouble();
    double pL = postsLen.toDouble();
    double cL = commentsLen.toDouble();
    double lL = likesLen.toDouble();
    double gL = groupLen.toDouble();
    double catL = categoriesLen.toDouble();
    double mL = modosLen.toDouble();
    double aL = adminsLen.toDouble();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: brownDark,
        ),
        body: SingleChildScrollView(
          child:  Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                'Compteurs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Card(
                      child: ListTile(
                    title: Text('Nombre d\'utilisateurs'),
                    subtitle: Row(
                      children: [
                        Text(usersLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 10.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: uL,
                      onChanged: (value) {
                        setState(() {
                          uL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                  SizedBox(height: 10,),
                  Card(
                      child: ListTile(
                    title: Text('Nombre de posts'),
                    subtitle: Row(
                      children: [
                        Text(postsLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 10.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: pL,
                      onChanged: (value) {
                        setState(() {
                          pL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                  SizedBox(height: 10,),
                  Card(
                      child: ListTile(
                    title: Text('Nombre de commentaires'),
                    subtitle: Row(
                      children: [
                        Text(commentsLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 20.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: cL,
                      onChanged: (value) {
                        setState(() {
                          cL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                  SizedBox(height: 10,),
                  Card(
                      child: ListTile(
                    title: Text('Nombre de likes'),
                    subtitle: Row(
                      children: [
                        Text(likesLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 100.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: lL,
                      onChanged: (value) {
                        setState(() {
                          lL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                  SizedBox(height: 10,),
                  Card(
                      child: ListTile(
                    title: Text('Nombre de groupes'),
                    subtitle: Row(
                      children: [
                        Text(groupLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 20.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: gL,
                      onChanged: (value) {
                        setState(() {
                          gL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                  SizedBox(height: 10,),
                  Card(
                      child: ListTile(
                    title: Text('Nombre de cat??gories'),
                    subtitle: Row(
                      children: [
                        Text(categoriesLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 10.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: catL,
                      onChanged: (value) {
                        setState(() {
                          catL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                  SizedBox(height: 10,),
                  Card(
                      child: ListTile(
                    title: Text('Nombre de mod??rateurs'),
                    subtitle: Row(
                      children: [
                        Text(modosLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 10.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: mL,
                      onChanged: (value) {
                        setState(() {
                          mL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                  SizedBox(height: 10,),
                  Card(
                      child: ListTile(
                    title: Text('Nombre d\'administrateurs'),
                    subtitle: Row(
                      children: [
                        Text(adminsLen.toString()),
                        Slider(
                      min: 0.0,
                      max: 10.0,
                      activeColor: brown,
                      inactiveColor: Colors.grey.shade300,
                      thumbColor: turquoise,
                      value: aL,
                      onChanged: (value) {
                        setState(() {
                          aL = value;
                        });
                      },
                    ),
                      ],
                    )
                  )),
                ],
              ),
              
            ],
          ),
        ) ,)
        );
  }
}
