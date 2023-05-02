import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/create_car/create_car.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../data/models/user_data.dart';
import '../../../data/provider/user_repository.dart';
import '../../../data/services/firebase_services.dart';
import '../../../utils/drawer/drawer_menu.dart';
import '../auth/login/login_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 3;
  final _controllerLogin = LoginController();

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      bottomNavigationBar: GNav(
        gap: 8,
        tabBackgroundColor: Colors.mainColor,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(icon: Icons.favorite, text: 'Favoritos'),
          GButton(
            icon: Icons.search,
            text: 'Buscar',
          ),
          GButton(
            icon: Icons.person,
            text: 'Perfil',
          ),
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
            FutureBuilder(
              future: getUser(),
              builder: (context, snapshot){
                print(snapshot);
                if(snapshot.hasData){
                  UserData user = snapshot.data!;
                  bool comprove = user.premium;
                  print(comprove);
                  if(comprove = true){
                    print('holahola');
                  }else{
                    toast('Necesitas ser premium');
                  }
                  return Container();
                }else{
                  return CircularProgressIndicator();
                }
              },
            );
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
              if (snapshot.hasData) {
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
                    _buildListTile(context, Icons.add_card_sharp, 'Hazte Premium','/premium'),
                    const SizedBox(height: 10.0),
                    _buildListTile(context, Icons.person_outline, 'Crea para la comunidad','/create_car'),
                    const SizedBox(height: 10.0),
                    _buildListTile(context, Icons.favorite, 'Mis favoritos','/favorites'),
                    const SizedBox(height: 10.0),
                    _buildListTile(context, Icons.star, 'Trailers Nuevos Coches','/billboard'),
                    const SizedBox(height: 10.0),
                    _buildListTile(
                        context, Icons.person_outline, 'Cerrar sesión','/login'),
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
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title,String route) {
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
        if(title == "Cerrar sesión"){
          _controllerLogin.deleteUserSession();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
                (_) => false,
          );
        }else{Navigator.pushReplacementNamed(context, route);


        }
      },
    );
  }
}
