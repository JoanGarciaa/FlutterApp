import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/car.dart';
import '../models/user_data.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
User? currentUser = FirebaseAuth.instance.currentUser;

bool _isLiked = false;

bool get isLiked => _isLiked;

class FirebaseRepository extends ChangeNotifier {}

Future<List<Car>> getAllCars() async {
  List<Car> cars = [];
  CollectionReference collectionReferenceUser = db.collection('cars');
  QuerySnapshot queryUser = await collectionReferenceUser.get();
  queryUser.docs.forEach((element) {
    final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    Car car = Car(
        id: element.id,
        brand: data['brand'],
        model: data['model'],
        image: data['image'],
        image2: data['image2'],
        max_speed: data['max_speed'],
        cv: data['cv'],
        fuel: data['fuel'],
        engine: data['engine'],
        favorite: data['favorite'],
        price: data['price'],
        torque: data['torque'],
        weight: data['weight']);
    cars.add(car);
  });
  return cars;
}

Future<Car?> getCar(String? id) async {
  Car? car;
  final snapshot =
      await FirebaseFirestore.instance.collection('cars').doc(id).get();
  final data = snapshot.data();
  car = Car(
      id: data!['id'],
      brand: data!['brand'],
      model: data['model'],
      image: data['image'],
      image2: data['image2'],
      max_speed: data['max_speed'],
      cv: data['cv'],
      price: data['price'],
      fuel: data['fuel'],
      engine: data['engine'],
      favorite: data['favorite'],
      torque: data['torque'],
      weight: data['weight']);
  return car;
}

Future<void> favoriteCar(String idCar, String? idUser) async {
  UserData? user;
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser = await collectionReferenceUser
      .where('email', isEqualTo: currentUser?.email)
      .get();
  queryUser.docs.forEach((element) {
    final Map<String, dynamic> data =
        queryUser.docs[0].data() as Map<String, dynamic>;
    user = UserData(
        email: data['email'],
        password: data['password'],
        sex: data['sex'],
        username: data['username'],
        years: data['years'],
        favorite_cars: data['favorite_cars'],
        image: data['image'],
        premium: data['premium']);
  });
  List? carList = user?.favorite_cars;
  if (!carList!.contains(idCar)) {
    carList.add(idCar);
    _isLiked = true;
  } else {
    carList.remove(idCar);
    _isLiked = false;
  }

  await db.collection('cars').doc(idCar).update({'favorite': true});
  await db.collection('users').doc(idUser).update({'favorite_cars': carList});
}

Future<void> addCar(String brandCar, String modelCar,int cvCar, String fuelCar, int maxSpeedCar, String engineCar, int priceCar, int nmCar, int weightCar, String imageCar  ) async {
  Random random = Random();
  int randomNumber = random.nextInt(10001) + 10000;
  String id = randomNumber.toString();
  String brand = brandCar;
  String model = modelCar;
  int cv = cvCar;
  String fuel = fuelCar;
  int max_speed = maxSpeedCar;
  String engine = engineCar;
  int price = priceCar;
  int nm = nmCar;
  int weight = weightCar;
  String image = imageCar;
  bool favorite = true;

  await db.collection('cars').doc(id).set({
    'id': id,
    'brand': brand,
    'model': model,
    'cv': cv,
    'max_speed': max_speed,
    'favorite': favorite,
    'engine': engine,
    'fuel': fuel,
    'image': image,
    'price': price,
    'torque': nm,
    'weight': weight,
    'image2': ""
  });
}
