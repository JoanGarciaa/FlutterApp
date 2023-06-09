import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/favorites/favorites_controller.dart';
import 'package:flutter_app/ui/pages/favorites/widgets/card_car.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../data/models/car.dart';
import '../../../data/services/firebase_services.dart';
import '../../../utils/drawer/drawer_menu.dart';
import '../../../utils/fonts/fonts.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _controller = FavoritesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: GNav(
        gap: 8,
        tabBackgroundColor: Colors.mainColor,
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.favorite, text: 'Favoritos'),
          GButton(icon: Icons.search, text: 'Buscar'),
          GButton(icon: Icons.person, text: 'Perfil'),
        ],
        selectedIndex: _controller.currentIndex,
        onTabChange: (index) {
          setState(() {
            _controller.currentIndex = index;
          });
          if (_controller.currentIndex == 0) {
            Navigator.pushReplacementNamed(context, '/');
          }
          if (_controller.currentIndex == 2) {
            Navigator.pushReplacementNamed(context, '/search');
          }
          if (_controller.currentIndex == 3) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
      drawer: const HomeDrawer(),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://cdn.autobild.es/sites/navi.axelspringer.es/public/media/image/2018/01/mazda-rx-7_4.jpg"),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 100,
                child: FutureBuilder(
                  future: _controller.getValueGarage(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      int? value = snapshot.data;
                      String formattedPrices = value.toString();
                      if (formattedPrices.length >= 7) {
                        _controller.formattedPrice =
                            formattedPrices.replaceAllMapped(
                                RegExp(r'^(\d{1,3})(\d{3})(\d{3})$'),
                                (Match m) => '${m[1]}.${m[2]}.${m[3]}');
                      } else {
                        _controller.formattedPrice =
                            formattedPrices.replaceAllMapped(
                                RegExp(r'^(\d{1,3})(\d{3})+$'),
                                (Match m) => '${m[1]}.${m[2]}');
                      }
                      return Center(
                          child: Text(
                        '${_controller.formattedPrice}€',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            letterSpacing: 2,
                            fontFamily: AppFonts.roboto),
                      ));
                    } else {
                      return const LinearProgressIndicator(
                        color: Colors.secondaryColor,
                        backgroundColor: Colors.grey,
                      );
                    }
                  }),
                )),
            CardCar()
          ],
        ),
      ),
    );
  }
}
