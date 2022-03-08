import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/refresh.dart';
import 'package:ressources_relationnelles_v1/commons/widgets/search/postsLikedCard.dart';
import 'package:ressources_relationnelles_v1/services/search.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: brownLight,
      appBar: AppBar(
        backgroundColor: brown,
        elevation: 0,
        title: Text('Ressources Relationnelles'),
        actions: [
          IconButton(
          onPressed: () {
            showSearch(
            context: context, 
            delegate: CustomSearchDelegate());
          }, 
          icon: Icon(Icons.search)),
        ],
      ),
      body : PlaneIndicator(child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: he*0.03,),

            Column(
              children: [
                Text('Most Liked !', style: TextStyle(fontSize: he*0.03, color: Colors.grey[500]),),
                SizedBox(height: he*0.04,),
                postsLikedCard(context, wi, he, he),
                postsLikedCard(context, wi, he, he),
                postsLikedCard(context, wi, he, he)
              ],
            )
          ],
        ),
        ))
    );
  }
}