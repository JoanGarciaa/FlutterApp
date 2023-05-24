import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/provider/google_sign_in.dart';
import '../../../../data/services/auth.dart';
import '../../../../utils/methods/methods.dart';

class LoginController extends ChangeNotifier {
  bool isLoggedIn = false;
  String userId = '';

  loginUser(String email, String password, BuildContext context) async {
    try {
      await Auth().signInWithEmailAndPassword(email, password);
      if (Auth().currentUser?.emailVerified == true) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        Navigator.pushReplacementNamed(context, '/');
        //Methods.toast("Verifica tu correo", context);
      }
    } catch (error) {
      Methods.toast("El usuario no existe", context);
    }
  }

  googleLogin(BuildContext context) async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    var providerLoogin = provider.googleLoogin();
    if (providerLoogin != null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}
