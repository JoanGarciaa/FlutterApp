import 'package:flutter/material.dart';
import 'package:flutter_app/drawer/drawer_menu.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      bottomNavigationBar: GNav(
        gap: 8,
        tabBackgroundColor: Colors.mainColor,
        tabs: const [
          GButton(icon: Icons.home,text: 'Home',),
          GButton(icon: Icons.favorite,text: 'Favoritos'),
          GButton(icon: Icons.search,text: 'Buscar', ),
          GButton(icon: Icons.person,text: 'Perfil',),
        ],
        selectedIndex: currentIndex,
        onTabChange: (index){
          setState(() {
            currentIndex = index;
          });
          print(index);
          if(currentIndex == 0){
            Navigator.pushReplacementNamed(context, '/');
          }if(currentIndex == 1){
            Navigator.pushReplacementNamed(context, '/favorites');
          }if(currentIndex == 2){
            Navigator.pushReplacementNamed(context, '/search');
          }
        },
      ),
      appBar: AppBar(
        title: const Text(
          "AutoSpecs",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        leading: IconButton(
          icon: const Icon(Icons.view_headline_sharp),
          color: Colors.black,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
    );
  }
}
