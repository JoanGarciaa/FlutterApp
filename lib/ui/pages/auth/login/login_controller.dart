
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../data/provider/google_sign_in.dart';
import '../../../../data/services/auth.dart';

class LoginController{

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  loginUser(String email, String password, BuildContext context) async {
    try{
      await Auth().signInWithEmailAndPassword(email,password);
      if(Auth().currentUser?.emailVerified == true){
        toast("Bienvenido $email");
        Navigator.pushReplacementNamed(context, '/');
      }else{
        toast("Verifica tu correo");
      }
    }catch(error){
      toast("El usuario no existe");
    }
  }

  googleLogin(BuildContext context)async{
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    var providerLoogin = provider.googleLoogin();
    if (providerLoogin != null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}