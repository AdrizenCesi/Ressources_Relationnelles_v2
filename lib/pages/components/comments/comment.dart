import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/comments/myCommentCard.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/accueil/comments/yourCommentCard.dart';

class Comment extends StatefulWidget {
  Comment({Key? key}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: brown,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: brownDark,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios)),
          title: Text('Comments'),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: he*0.08, 
        decoration: BoxDecoration(
          color: brown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: Row(
          children: [
            Flexible(child: SizedBox(
              child: TextField(
                decoration: textInputDecoration.copyWith(hintText: 'your message...', hintStyle: TextStyle(color: Colors.white))
              ),
            )),
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.send, color: brownLight,))
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
        child: Column(children: [
          yourComment(wi),
          myComment(wi),
          yourComment(wi),
          yourComment(wi)
        ],),
      ),)
    );
  }
}