
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/dashboard/components/commentsList.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/dashboard/components/postsList.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/dashboard/components/stats.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/dashboard/components/userList.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/popmenu/help/help.dart';

class Dashboard extends StatefulWidget {
  
  Dashboard({Key? key, required this.uId}) : super(key: key);
  final String? uId;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> { 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: brownDark,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text('Utilitaires', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
            children: [
              Card(
                color: Colors.grey[100],
                shadowColor: brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersList()));
                  },
                  title: Text('Tous les utilisateurs'),
                  leading: Container(
                    width: 40, 
                    height: 40,
                    decoration: BoxDecoration(
                      color:brown,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.person, color: Colors.white,),),),
              ),
              SizedBox(height: 10,),
              Card(
                color: Colors.grey[100],
                shadowColor: brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostsList()));
                  },
                  title: Text('Tous les posts'),
                  leading: Container(
                    width: 40, 
                    height: 40,
                    decoration: BoxDecoration(
                      color:brown,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.post_add,color: Colors.white,),),),
              ),
              SizedBox(height: 10,),
              Card(
                color: Colors.grey[100],
                shadowColor: brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CommentsList()));
                  },
                  title: Text('Tous les commentaires'),
                  leading: Container(
                    width: 40, 
                    height: 40,
                    decoration: BoxDecoration(
                      color:brown,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.comment, color: Colors.white,),),),
              )
            ],
          ),),

         Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text('Statistiques', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Compteurs()));
                },
                child: 
              Container(
                width: 150, 
                    height: 250,
                    decoration: BoxDecoration(
                      color:brown,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.format_list_bulleted, color: Colors.white, size: 100,),
                        Text('Compteurs', style: TextStyle(color: Colors.white),)
                      ],
                    ),
              ),),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Help()));
                },
                child: 
              Container(
                width: 150, 
                    height: 250,
                    decoration: BoxDecoration(
                      color:brown,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart, color: Colors.white, size: 100,),
                        Text('Graphiques', style: TextStyle(color: Colors.white),)
                      ],
                    ),
              ),),
            ],
          )
        ],
      ),
    );
  }
}