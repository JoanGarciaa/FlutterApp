import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/services/firebase_services.dart';
import '../../main.dart';
import '../../ui/pages/favorites/favorites_page.dart';
import '../../ui/pages/home/home_page.dart';
import '../../ui/pages/home/search_car/search_car.dart';
import '../../ui/pages/profile/profile_page.dart';

void main() => runApp(const MyApp());

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.mainColor,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(children: const [
          Image(
              width: 200,
              height: 150,
              image: AssetImage('assets/images/logogaraje.png')),
          SizedBox(height: 1),
        ]),
      );

  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.home, color: Colors.terciaryColor,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            title: const Text('Mis Favoritos'),
            leading: const Icon(Icons.favorite,color: Colors.red,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FavoritesPage()));
            },
          ),
          ListTile(
            title: const Text('Buscar coches'),
            leading: const Icon(Icons.car_crash,color: Colors.terciaryColor,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchCarPage()));
            },
          ),
          ListTile(
            title: const Text('Perfil'),
            leading: const Icon(Icons.person,color: Colors.terciaryColor,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app,color: Colors.terciaryColor,),
            title: const Text('Cerrar App'),
            onTap: () {
              exit(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app,color: Colors.terciaryColor,),
            title: const Text('crear coche'),
            onTap: () {
              addCar();
            },
          ),
        ],
      );
}
