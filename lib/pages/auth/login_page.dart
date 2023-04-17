import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../provider/google_sign_in.dart';
import '../../services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Widget _title() {
    return const Text('Firebase Auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerEmail,
              decoration: const InputDecoration(hintText: 'Correo'),
            ),
            TextField(
              controller: _controllerPassword,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await Auth()
                        .signInWithEmailAndPassword(
                        _controllerEmail.text, _controllerPassword.text)
                        .then((_) {
                      if (Auth().currentUser?.emailVerified == true) {
                        Navigator.pushNamed(context, '/');
                        Fluttertoast.showToast(
                            msg: "Bienvenido ${_controllerPassword.text}",
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        _controllerEmail.clear();
                        _controllerPassword.clear();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Verifica tu email",
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  } catch (AuthException) {
                    Fluttertoast.showToast(
                        msg: "Este usuario no existe",
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Text('Login')),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity, 50)),
              icon: FaIcon(FontAwesomeIcons.google),
              label: Text("Signup with google"),
              onPressed: () {
                final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
                var hol = provider.googleLoogin();
                if(hol != null){
                  Navigator.pushNamed(context, '/');
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Register'))
          ],
        ),
      ),
    );
  }
}