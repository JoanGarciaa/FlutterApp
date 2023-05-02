
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_data.dart';
import '../services/firebase_services.dart';

Future<UserData?> getUser() async {
  UserData? user;
  User? currentUser = FirebaseAuth.instance.currentUser;
  print(currentUser?.email);
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
        premium: data['premium']
    );
  });
  print("esti no va?$user");
  return user;
}

Future<List> getUsers() async {
  List user = [];
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser = await collectionReferenceUser.get();
  queryUser.docs.forEach((element) {
    final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    final person = {"username": data['username'], "uid": element.id};

    user.add(person);
  });
  // for (var element in queryUser.docs) {
  //   final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
  //   final person = {"username": data['username'], "uid": element.id};
  //
  //   user.add(person);
  // }
  return user;
}

Future<void> createUserDB(UserData user_data) async {
  await db.collection('users').doc(user_data.email).set({
    'email': user_data.email,
    'password': user_data.password,
    'username': user_data.username,
    'years': user_data.years,
    'sex': user_data.sex,
    'favorite_cars': user_data.favorite_cars
  });
}

Future<void> addUser(String name) async {
  await db.collection('users').add({'name': name});
}

Future<void> modifyUser(String? uid, bool premium) async {
  await db.collection('users').doc(uid).update({'premium': premium});
}

Future<void> deleteUser(String uid) async {
  await db.collection('users').doc(uid).delete();
}