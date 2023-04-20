import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUser() async{
  List user = [];
  CollectionReference collectionReferenceUser = db.collection('users');
  QuerySnapshot queryUser = await collectionReferenceUser.get();
  queryUser.docs.forEach((element) {
    final Map<String,dynamic> data = element.data() as Map<String,dynamic>;
    final person = {
      "name": data['name'],
      "uid": element.id
    };

    user.add(person);
  });
  return user;
}

Future<void> createUserDB(String email, String password, String username, String years, String sex) async{
  await db.collection('users').add({'email':email,'password':password,'username':username,'years':years,'sex':sex});
}

Future<void> addUser(String name) async{
  await db.collection('users').add({'name':name});
}

Future<void> modifyUser(String uid, String newName) async{
  await db.collection('users').doc(uid).update({'name':newName});
}

Future<void> deleteUser(String uid) async{
  await db.collection('users').doc(uid).delete();
}