import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/models/user_data.dart';
import '../../../../data/services/firebase_services.dart';

class InfoCarController extends ChangeNotifier {
  String USER_DB = 'users';
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void set isLiked(bool value) {
    value = isLiked;
  }

  Future<UserData> getUser() async {
    late UserData user;
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection(USER_DB)
        .where('email', isEqualTo: currentUser?.email)
        .get()
        .then((documents) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in documents.docs) {
        user = UserData.fromMap(documentSnapshot.data());
        print(user.email);
      }
    });
    return user;
  }

  void afterFistLayout() {
    // isFavoriteCar();
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
      notifyListeners();
    } else {
      carList.remove(idCar);
      _isLiked = false;
      notifyListeners();
    }

    await db.collection('users').doc(idUser).update({'favorite_cars': carList});
  }

  void isFavoriteCar(String idCar) async {
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
    if (carList!.contains(idCar)) {
      print('estoy donde el like tiene que ser true');
      _isLiked = true;
      notifyListeners();
    } else {
      print('estoy donde el like tiene que ser false');
      _isLiked = false;
      notifyListeners();
    }

    await db
        .collection('users')
        .doc(currentUser!.email)
        .update({'favorite_cars': carList});
  }
}
