import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../data/models/user_data.dart';
import '../../../data/provider/user_repository.dart';
import '../../../data/services/firebase_services.dart';
import '../../../utils/drawer/drawer_menu.dart';

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
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      bottomNavigationBar: GNav(
        gap: 8,
        tabBackgroundColor: Colors.mainColor,
        tabs: const [
          GButton(icon: Icons.home, text: 'Home',),
          GButton(icon: Icons.favorite, text: 'Favoritos'),
          GButton(icon: Icons.search, text: 'Buscar',),
          GButton(icon: Icons.person, text: 'Perfil',),
        ],
        selectedIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
          if (currentIndex == 0) {
            Navigator.pushReplacementNamed(context, '/');
          }
          if (currentIndex == 1) {
            Navigator.pushReplacementNamed(context, '/favorites');
          }
          if (currentIndex == 2) {
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
            if (_scaffoldKey.currentState != null) {
              _scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.mainColor,
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData){
                UserData? user = snapshot.data;
                return Column(
                  children: [
                    const SizedBox(height: 50.0),
                    CircleAvatar(
                      radius: 75.0,
                      backgroundImage: NetworkImage(user!.image),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      user.username,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Divider(
                      color: Colors.terciaryColor,
                    ),
                    const SizedBox(height: 20.0),
                    _buildListTile(context, Icons.person_outline, 'Mi perfil'),
                    const SizedBox(height: 10.0),
                    _buildListTile(context, Icons.favorite, 'Mis favoritos'),
                    const SizedBox(height: 10.0),
                    _buildListTile(context, Icons.settings, 'Configuración'),
                    const SizedBox(height: 10.0),
                    _buildListTile(context, Icons.exit_to_app, 'Cerrar sesión'),
                    const SizedBox(height: 20.0),
                    const Divider(
                      height: 5,
                      color: Colors.terciaryColor,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Versión 1.0.0',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: () {
        // Aquí puedes añadir cualquier lógica que desees al hacer clic en la opción del perfil
      },
    );
  }
}
