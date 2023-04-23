import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_data.dart';
import 'package:flutter_app/services/firebase_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../drawer/drawer_menu.dart';
import '../../fonts/fonts.dart';
import '../../models/car.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoaded = false;
  bool _isClicked = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  UserData? user;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleClick() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

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
      //TODO bottomNavigationBar: Container(width: 100,),
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
                Navigator.pushNamed(context, '/profile');
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
                height: 510,
                width: 700,
                child: FutureBuilder(
                  future: getAllCars(),
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
                                // getCar(snapshot.data?[index]['uid']);
                                print("HOOL");
                                await Navigator.pushNamed(context, '/info-car',
                                    arguments: {
                                      "brand": cars[index].brand,
                                      "model": cars[index].model,
                                      "image": cars[index].image,
                                      "max_speed": cars[index].max_speed,
                                      "fuel": cars[index].fuel,
                                      "cv": cars[index].cv,
                                      "engine": cars[index].engine,
                                      "id": cars[index].id,
                                    });
                                setState(() {});
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        cars[index].image),
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
                                            child: Icon(Icons.favorite, color: _isClicked? Colors.red:Colors.grey,),
                                            onTap: () {
                                              _handleClick();
                                              favoriteCar(cars[index].id,currentUser?.email);
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
