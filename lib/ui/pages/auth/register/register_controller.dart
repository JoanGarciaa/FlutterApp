
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/user_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../data/provider/user_repository.dart';
import '../../../../data/services/auth.dart';
import '../../../../utils/methods/methods.dart';

class RegisterController{
  UserData? userData;
  final repository = UserRepository();

  createUser(String email, String password,String sex, String username, int years, BuildContext context)async {
    try{
      await Auth()
          .createUserWithEmailAndPassword(email,password)
          .then((_) {
        Auth().sendEmailVerification();
        userData = UserData(email: email,password: password,sex: sex,username: username,years: years,favorite_cars: [],image: "https://cdn.autobild.es/sites/navi.axelspringer.es/public/media/image/2018/01/mazda-rx-7_4.jpg",premium: false);
        repository.createUserDB(userData!);
        Methods.toast("Registro con éxito", context);
        Navigator.pushReplacementNamed(context, '/login');
      });
    }catch(error){
      if (kDebugMode) {
        print(error);
      }
      Methods.toast("No se ha podido crear el usuario", context);
    }
  }
}