import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/groupes/chat/myMessage.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/groupes/chat/yourMessage.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: brownLight,
      appBar: AppBar(
        backgroundColor: brownDark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },),
        title: Text('Flutt\'iZ'),
        centerTitle: true,
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

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              myMessage(wi),
              yourMessage(wi),
              yourMessage(wi),
              myMessage(wi),
              yourMessage(wi),

            ],
          ))
      )
    );
  }
}