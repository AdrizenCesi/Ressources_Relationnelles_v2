import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brownLight,
      body : Center(child: Text('Search'),),
    );
  }
}