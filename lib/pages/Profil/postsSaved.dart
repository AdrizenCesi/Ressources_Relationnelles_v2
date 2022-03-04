import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/profil/myPostsSavedCard.dart';

class PostsSaved extends StatefulWidget {
  PostsSaved({Key? key}) : super(key: key);

  @override
  State<PostsSaved> createState() => PostsSavedState();
}

class PostsSavedState extends State<PostsSaved> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: brown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios)),
          title: Text('My Posts Saved'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
        child: Column(
          children: [
            myPostsSavedCard(context, wi, he, he),
            myPostsSavedCard(context, wi, he, he),
            myPostsSavedCard(context, wi, he, he),
            myPostsSavedCard(context, wi, he, he),
          ],
        ),
      ),)
    );
  }
}