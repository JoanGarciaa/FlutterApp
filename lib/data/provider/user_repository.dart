import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_data.dart';
import '../services/firebase_services.dart';

class UserRepository extends ChangeNotifier {
  String USER_DB = 'users';

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

  Future<List> getUsers() async {
    List user = [];
    CollectionReference collectionReferenceUser = db.collection('users');
    QuerySnapshot queryUser = await collectionReferenceUser.get();
    queryUser.docs.forEach((element) {
      final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      final person = {"username": data['username'], "uid": element.id};

      user.add(person);
    });
    return user;
  }

  Future<void> createUserDB(UserData user_data) async {
    await db.collection('users').doc(user_data.email).set({
      'email': user_data.email,
      'password': user_data.password,
      'username': user_data.username,
      'years': user_data.years,
      'sex': user_data.sex,
      'favorite_cars': user_data.favorite_cars,
      'premium': false,
      'image': user_data.image
    });
  }

  Future<void> addUser(String name) async {
    await db.collection('users').add({'name': name});
  }

  Future<void> userPremium(String? uid, bool premium) async {
    await db.collection('users').doc(uid).update({'premium': premium});
  }

  Future<void> modifyUser(String? uid, bool premium) async {
    await db.collection('users').doc(uid).update({'premium': premium});
  }

  Future<void> deleteUser(String uid) async {
    await db.collection('users').doc(uid).delete();
  }
}
