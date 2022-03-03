import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressources_relationnelles_v1/pages/Accueil/accueil.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/groupes.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';
import 'package:ressources_relationnelles_v1/pages/Search/search.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    List<Widget> _widgetOptions = <Widget>[
  Accueil(),
  Groupes(),
  Search(),
  Profil()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        unselectedItemColor: brownLight.withOpacity(0.6),
        selectedItemColor: brownLight,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            backgroundColor: brownDark,
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users),
            backgroundColor: brownDark,
            label: 'Groupes',
          ),

          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            backgroundColor: brownDark,
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userAlt),
            backgroundColor: brownDark,
            label: 'Profil',
          ),
          ],),
    );
  }
}