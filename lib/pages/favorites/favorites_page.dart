import 'package:flutter/material.dart';
import 'package:flutter_app/drawer/drawer_menu.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../fonts/fonts.dart';
import '../../models/car.dart';
import '../../services/firebase_services.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 1;
  bool _isClicked = false;

  void _handleClick() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          }if(currentIndex == 2){
            Navigator.pushReplacementNamed(context, '/search');
          }if(currentIndex == 3){
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
            padding: EdgeInsets.only(right: 8.0),
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
            Container(
              height: 100,
              child: const Center(
                  child: Text(
                    'TUS FAVORITOS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        fontFamily: AppFonts.roboto),
                  )),
            ),
            Container(
                height: 600,
                child: FutureBuilder(
                  future: getMyFavoriteCars(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      List<Car>? cars = snapshot.data;
                      return ListView.builder(
                        itemCount: cars?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5.0,
                            shadowColor: Colors.terciaryColor,
                            key: Key(cars![index].id),
                            child: GestureDetector(
                              onTap: () async {
                                await Navigator.pushNamed(context, '/info-car',
                                    arguments: {
                                      "car": cars[index],
                                    });
                                setState(() {});
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(cars[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        cars[index].brand,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: double.infinity,
                                      height: 45,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              cars[index].model,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Icon(
                                              Icons.favorite,
                                              color: _isClicked
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                            onTap: () {
                                              _handleClick();
                                              favoriteCar(cars[index].id,
                                                  currentUser?.email);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ))
          ],
        ),
      ),
    );
  }
}
