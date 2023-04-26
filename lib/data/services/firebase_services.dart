import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/car.dart';
import '../models/user_data.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
User? currentUser = FirebaseAuth.instance.currentUser;


class FirebaseRepository{

  Future<List<Car>> getAllCarsWithFavorite() async {
    List<Car> cars = [];
    List<Car> favoriteCarsList = await getMyFavoriteCars();
    CollectionReference collectionReferenceUser = db.collection('cars');
    QuerySnapshot queryUser = await collectionReferenceUser.get();
    queryUser.docs.forEach((element) {
      bool isCarFavorite = false;
      final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      for(Car car in favoriteCarsList){
        if(car.id == data['id']){
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
      );
      cars.add(car);
    });
    return cars;
  }
}

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
      price: data['price']
    );
    cars.add(car);
  });
  return cars;
}



Future<List<Car>> getAllCarsForSearch(String? brand) async {
  List<Car> cars = [];
  CollectionReference collectionReferenceUser = db.collection('cars');
  if(brand == "Ver todos" || brand == ""){
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
      );
      cars.add(car);
    });
  }else{
    QuerySnapshot queryUser = await collectionReferenceUser.where('brand', isEqualTo: brand).get();
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
      );
      cars.add(car);
    });
  }

  return cars;
}

Future<Car?>getCar(String? id) async {
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
  );
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
    final Map<String, dynamic> data = queryUser.docs[0].data() as Map<String, dynamic>;
    user = UserData(
        email: data['email'],
        password: data['password'],
        sex: data['sex'],
        username: data['username'],
        years: data['years'],
        favorite_cars: data['favorite_cars'],
        image: data['image']);
  });
  List? carList = user?.favorite_cars;
  if (!carList!.contains(idCar)) {
    carList.add(idCar);
  } else {
    carList.remove(idCar);
  }
  await db.collection('users').doc(idUser).update({'favorite_cars': carList});
}


Future<List<Car>>getMyFavoriteCars()async{
  List<Car> favoriteCars = [];
  QuerySnapshot? queryCar;
  List<QuerySnapshot?> queryCarList = [];
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser = await collectionReferenceUser
      .where('email', isEqualTo: currentUser?.email)
      .get();

    for(String id in queryUser.docs[0].get('favorite_cars')){
      CollectionReference collectionReferenceCar = db.collection('cars');
      queryCar = await collectionReferenceCar
          .where('id', isEqualTo: id)
          .get();
      queryCarList.add(queryCar);
    }

  queryCarList.forEach((element) {
    element?.docs.forEach((element) {

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
      );
      favoriteCars.add(car);
      int totalPrices = favoriteCars.fold(0, (previousValue, car) => previousValue + car.price);
      print(totalPrices);
    });
  });

  return favoriteCars;
}

Future<int>getTotalValueGarage()async{
  List<Car> favoriteCars = [];
  QuerySnapshot? queryCar;
  List<QuerySnapshot?> queryCarList = [];
  int totalPrices = 0;
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser = await collectionReferenceUser
      .where('email', isEqualTo: currentUser?.email)
      .get();

  for(String id in queryUser.docs[0].get('favorite_cars')){
    CollectionReference collectionReferenceCar = db.collection('cars');
    queryCar = await collectionReferenceCar
        .where('id', isEqualTo: id)
        .get();
    queryCarList.add(queryCar);
  }

  queryCarList.forEach((element) {
    element?.docs.forEach((element) {

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
      );
      favoriteCars.add(car);
      totalPrices = favoriteCars.fold(0, (previousValue, car) => previousValue + car.price);
      print(totalPrices);
    });
  });

  return totalPrices;
}



Future<void> addCar() async {
  String id = "1012";
  String brand = "Nissan";
  String model = "GTR R34";
  int cv = 400;
  int max_speed = 0;
  bool favorite = false;
  String engine = "RB26DETT";
  String image =
      "https://www.autonocion.com/wp-content/uploads/2020/05/Nissan-GT-R-R34-28.jpg";
  String image2 =
      "https://www.autonocion.com/wp-content/uploads/2020/05/Nissan-GT-R-R34-28.jpg";
  String fuel = "Gasoline";
  int price = 1;
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
    'image2': image2,
    'price' : price
  });
}


