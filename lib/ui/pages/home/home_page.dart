import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pages.dart';
import 'package:flutter_app/ui/pages/home/home_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../data/models/car.dart';
import '../../../data/models/user_data.dart';
import '../../../data/services/firebase_services.dart';
import '../../../utils/drawer/drawer_menu.dart';
import '../../../utils/fonts/fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoaded = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  UserData? user;
  bool isFavoriteSelected = false;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  Car? car;
  List<bool> favoriteCars = [];

  final _controller = HomeController();

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
          if(currentIndex == 1){
            Navigator.pushNamed(context, '/favorites');
          }if(currentIndex == 2){
            Navigator.pushNamed(context, '/search');
          }if(currentIndex == 3){
            Navigator.pushNamed(context, '/profile');
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
                Container(
                  height: 100,
                  child: const Center(
                      child: Text(
                        'LOS MÁS BUSCADOS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 2,
                            fontFamily: AppFonts.roboto),
                      )),
                ),
                Container(
                    height: 491,
                    child: FutureBuilder(
                      future: _controller.getCarsHome(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          // isFavoriteSelected = car?.favorite ?? false;
                          List<Car> cars = snapshot.data;
                          return ListView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5.0,
                                shadowColor: Colors.terciaryColor,
                                key: Key(cars[index].id),
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
                                                  color: (cars[index].favorite == true || isFavoriteSelected )
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                                onTap: () {
                                                  favoriteCar(cars[index].id, currentUser?.email);
                                                  setState(() {
                                                    isFavoriteSelected = true;
                                                  });
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
                        }else if(snapshot.hasError){
                          return Text("Error: ${snapshot.error}");
                        }
                        else {
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
