import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/car.dart';

import '../models/user_data.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
User? currentUser = FirebaseAuth.instance.currentUser;

Future<List> getUsers() async{
  List user = [];
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser = await collectionReferenceUser.get();
  queryUser.docs.forEach((element) {
    final Map<String,dynamic> data = element.data() as Map<String,dynamic>;
    final person = {
      "username": data['username'],
      "uid": element.id
    };

    user.add(person);
  });
  return user;
}

Future<UserData?> getUser() async{
  UserData? user;
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser =  await collectionReferenceUser.where('uid', isEqualTo: currentUser?.uid).get();
  queryUser.docs.forEach((element) {
    final Map<String, dynamic> data = queryUser.docs[0].data() as Map<String, dynamic>;
    print(data['years']);
    user = UserData(
      email: data['email'],
      password: data['password'],
      sex: data['sex'],
      username: data['username'],
      years: data['years'],
      favorite_cars: [],
      image: data['image']
    );
    print("HOOOOOOOOOOOOOOOOOOOOOOOL $user");
  });


  return user;
}



Future<List<Car>> getAllCars() async{
  List<Car> cars = [];
  CollectionReference collectionReferenceUser = db.collection('cars');
  QuerySnapshot queryUser = await collectionReferenceUser.get();
  queryUser.docs.forEach((element) {
    final Map<String,dynamic> data = element.data() as Map<String,dynamic>;
     Car car = Car(
       id: element.id,
       brand: data['brand'],
       model: data['model'],
       image: data['image'],
       max_speed: data['max_speed'],
       cv: data['cv'],
       fuel: data['fuel'],
       engine: data['engine'],
       favorite: data['favorite'],
     );
    cars.add(car);
  });
  return cars;
}

getCar(String id) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('cars').doc(id)
      .get();
  final car = snapshot.data();
  return car;
}

Future<void> favoriteCar(String idCar,String? idUser) async{
  UserData? user;
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser =  await collectionReferenceUser.where('email', isEqualTo: currentUser?.email).get();
  queryUser.docs.forEach((element) {
    final Map<String, dynamic> data = queryUser.docs[0].data() as Map<String, dynamic>;
    user = UserData(
      email: data['email'],
      password: data['password'],
      sex: data['sex'],
      username: data['username'],
      years: data['years'],
      favorite_cars: data['favorite_cars'],
      image: data['image']
    );
  });
  List? carList = user?.favorite_cars;
  if(carList!.contains(idCar)){
    carList.remove(idCar);
    carList.add(idCar);
  }else{
    carList.add(idCar);
  }
  await db.collection('users').doc(idUser).update({'favorite_cars':carList});
}

Future<void> removeFavoriteCar(String idCar,String? idUser) async{
  getUser();
  List carList = [];
  carList.remove(idCar);
  await db.collection('users').doc(idUser).update({'favorite_cars':carList});
}

// Future<List<Car>>getMyFavoriteCars()async{
//   List<Car> favoriteCars;
//
//   return favoriteCars;
// }

Future<void> createUserDB(UserData user_data) async{
  await db.collection('users').doc(user_data.email).set({'email':user_data.email,'password':user_data.password,'username':user_data.username,'years':user_data.years,'sex':user_data.sex,'favorite_cars':user_data.favorite_cars});
}

Future<void> addUser(String name) async{
  await db.collection('users').add({'name':name});
}

Future<void> addCar() async{
  String id = "1011";
  String brand = "Nissan";
  String model = "GTR R34";
  int cv = 400;
  int max_speed = 0;
  bool favorite = false;
  String engine = "RB26DETT";
  String image = "https://www.autonocion.com/wp-content/uploads/2020/05/Nissan-GT-R-R34-28.jpg";
  String fuel = "Gasoline";
  await db.collection('cars').doc(id).set({'id':id,'brand':brand,'model':model,'cv':cv,'max_speed':max_speed,'favorite':favorite,'engine':engine,'fuel':fuel,'image':image});
}

Future<void> modifyUser(String uid, String newName) async{
  await db.collection('users').doc(uid).update({'name':newName});
}

Future<void> deleteUser(String uid) async{
  await db.collection('users').doc(uid).delete();
}