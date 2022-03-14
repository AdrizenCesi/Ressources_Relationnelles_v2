import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/createGroup.dart';
import 'package:ressources_relationnelles_v1/pages/components/addGroup/addGroup.dart';
import 'package:ressources_relationnelles_v1/pages/components/comments/comment.dart';

postCard(context, double w, double h, double heI, title, author, content,
    datePost, pageComment, String imgPost, String imgProfil, bodyProfil, favorite) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      children: [
        Container(
          height: h * 0.45,
          width: w * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Scaffold(appBar: AppBar(
                                    title:Text('Ressources Relationnelles'),
                                    backgroundColor: brownDark,
                                  ), body: bodyProfil),
                            ));
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imgProfil),
                      ),
                    ),
                    title: Text(title,
                        style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
                    subtitle: Text(author, style: TextStyle(color: secondaryColor.withOpacity(0.6)),),
                  ),
                  ListBody(
                    children: [
                      Text(content, style: TextStyle(fontSize: w*0.043, color: secondaryColor),),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        height: heI * 0.2,
                        child: Image.network(
                          imgPost,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        datePost,
                        style: TextStyle(color: secondaryColor.withOpacity(0.6)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: turquoise.withOpacity(0.4),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pageComment));
                          },
                          icon: Icon(
                            Icons.add_comment_outlined,
                            color: secondaryColor,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreationGroupe()));
                          },
                          icon: Icon(
                            Icons.ios_share_outlined,
                            color: secondaryColor,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_border,
                            color: secondaryColor,
                          )),
                      favorite
                    ],
                  )
                ],
              )),
        )
      ],
    ),
  );
}
