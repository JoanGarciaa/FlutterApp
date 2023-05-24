import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/car.dart';
import '../services/firebase_services.dart';

class CarRepository extends ChangeNotifier {
  String CAR_DB = 'cars';

  Future<List<Car>> getAllCarsForSearch(String? brand) async {
    List<Car> carList = [];

    if (brand == "Ver todos" || brand == "") {
      await FirebaseFirestore.instance.collection(CAR_DB).get().then((value) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in value.docs) {
          carList.add(Car.fromMap(documentSnapshot.data()));
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection(CAR_DB)
          .where('brand', isEqualTo: brand)
          .get()
          .then((value) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in value.docs) {
          carList.add(Car.fromMap(documentSnapshot.data()));
        }
      });
    }
    ;

    return carList;
  }

  Future<List<Car>> getAllCarsForSearch2(String? brand) async {
    print(getAllCarsForSearch(brand));
    List<Car> cars = [];
    CollectionReference collectionReferenceUser = db.collection('cars');
    if (brand == "Ver todos" || brand == "") {
      QuerySnapshot queryUser = await collectionReferenceUser.get();
      queryUser.docs.forEach((element) {
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        Car car = Car(
            id: element.id,
            brand: data['brand'],
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
        cars.add(car);
      });
    } else {
      QuerySnapshot queryUser =
          await collectionReferenceUser.where('brand', isEqualTo: brand).get();
      queryUser.docs.forEach((element) {
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        Car car = Car(
            id: element.id,
            brand: data['brand'],
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
        cars.add(car);
      });
    }
    return cars;
  }

  Future<int> getTotalValueGarage() async {
    List<Car> favoriteCars = [];
    QuerySnapshot? queryCar;
    List<QuerySnapshot?> queryCarList = [];
    int totalPrices = 0;
    User? currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference collectionReferenceUser = db.collection('users');
    QuerySnapshot queryUser = await collectionReferenceUser
        .where('email', isEqualTo: currentUser?.email)
        .get();

    for (String id in queryUser.docs[0].get('favorite_cars')) {
      CollectionReference collectionReferenceCar = db.collection('cars');
      queryCar = await collectionReferenceCar.where('id', isEqualTo: id).get();
      queryCarList.add(queryCar);
    }

    queryCarList.forEach((element) {
      element?.docs.forEach((element) {
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        Car car = Car(
            id: element.id,
            brand: data['brand'],
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
        favoriteCars.add(car);
        totalPrices = favoriteCars.fold(
            0, (previousValue, car) => previousValue + car.price);
        print(totalPrices);
      });
    });

    return totalPrices;
  }

  Future<List<Car>> getMyFavoriteCars() async {
    List<Car> favoriteCars = [];
    QuerySnapshot? queryCar;
    List<QuerySnapshot?> queryCarList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference collectionReferenceUser = db.collection('users');
    QuerySnapshot queryUser = await collectionReferenceUser
        .where('email', isEqualTo: currentUser?.email)
        .get();

    for (String id in queryUser.docs[0].get('favorite_cars')) {
      CollectionReference collectionReferenceCar = db.collection('cars');
      queryCar = await collectionReferenceCar.where('id', isEqualTo: id).get();
      queryCarList.add(queryCar);
    }

    queryCarList.forEach((element) {
      element?.docs.forEach((element) {
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        Car car = Car(
            id: element.id,
            brand: data['brand'],
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
        favoriteCars.add(car);
      });
    });

    return favoriteCars;
  }

  Future<List<Car>> getAllCarsWithFavorite() async {
    List<Car> cars = [];
    List<Car> favoriteCarsList = await getMyFavoriteCars();
    CollectionReference collectionReferenceUser = db.collection('cars');
    QuerySnapshot queryUser = await collectionReferenceUser.get();
    queryUser.docs.forEach((element) {
      bool isCarFavorite = false;
      final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      for (Car car in favoriteCarsList) {
        if (car.id == data['id']) {
          isCarFavorite = true;
        }
      }
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
          favorite: isCarFavorite,
          price: data['price'],
          torque: data['torque'],
          weight: data['weight']);
      cars.add(car);
    });
    return cars;
  }
}
