import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/car.dart';
import '../services/firebase_services.dart';

class CarRepository extends ChangeNotifier {
  String CAR_DB = 'cars';
  late Car hol;

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
        await FirebaseFirestore.instance.collection(CAR_DB)
          .where('brand', isEqualTo: brand).get().then((value) {
            for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
                in value.docs) {
              carList.add(Car.fromMap(documentSnapshot.data()));
            }
          });
      };

    return carList;
  }

  Future<List<Car>> getAllCarsForSearch2(String? brand) async {
    print(getAllCarsForSearch(brand));
    List<Car> cars = [];
    CollectionReference collectionReferenceUser = db.collection('cars');
    if (brand == "Ver todos" || brand == "") {
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
        final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
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

}
