import 'package:flutter/material.dart';
import 'package:ressources_relationnelles_v1/commons/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressources_relationnelles_v1/pages/Accueil/accueil.dart';
import 'package:ressources_relationnelles_v1/pages/Accueil/addPost.dart';
import 'package:ressources_relationnelles_v1/pages/Groupes/groupes.dart';
import 'package:ressources_relationnelles_v1/pages/Profil/profil.dart';
import 'package:ressources_relationnelles_v1/pages/Search/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final String? uId;
  HomeScreen({Key? key, required this.uId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var userData = {};
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();

      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uId)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(BuildContext context, String text) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(text),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    List<Widget> _widgetOptions = <Widget>[
  Accueil(uId: FirebaseAuth.instance.currentUser!.uid),
  Groupes(),
  Search(),
  Profil(uId: FirebaseAuth.instance.currentUser!.uid)
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Accueil(uId: FirebaseAuth.instance.currentUser!.uid);
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: PageStorage(bucket: bucket, child: currentScreen),
      //_widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: 
      (userData['role'].toString() == 'Role.redacteur')
     ? FloatingActionButton(
        onPressed: () {
           Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPostPage(),
                    ),
                  );
        }, 
        child: Icon(Icons.add), backgroundColor: accentColor,)
        : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: 
      BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight:Radius.circular(30), topLeft: Radius.circular(30))
          ),
          height: 50,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = Accueil(uId: FirebaseAuth.instance.currentUser!.uid);
                      currentTab = 0;
                    });
                  },
                  child: Icon(Icons.home_outlined),
                  ),

                  MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = Groupes();
                      currentTab = 0;
                    });
                  },
                  child: Icon(Icons.group_outlined)
                  ),
                  SizedBox.shrink(),

                  MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = Search();
                      currentTab = 0;
                    });
                  },
                  child: Icon(Icons.search),
                  ),

                  MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentScreen = Profil(uId: FirebaseAuth.instance.currentUser!.uid);
                      currentTab = 0;
                    });
                  },
                  child: Icon(Icons.home_max_outlined),
                  ),
              ],
            ),)
        )
      )
      /*BottomNavigationBar(
        showSelectedLabels: false,
        unselectedItemColor: turquoise.withOpacity(0.6),
        selectedItemColor: turquoise,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            backgroundColor: brownLight,
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users),
            backgroundColor: brownLight,
            label: 'Groupes',
          ),

          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            backgroundColor: brownLight,
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userAlt),
            backgroundColor: brownLight,
            label: 'Profil',
          ),
          ],),*/
    );
  }
}