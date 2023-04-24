import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../global_widgets/custom_rounded_button.dart';
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

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.mainColor,
      appBar: AppBar(
        title: const Text(
          "AutoSpecs",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logogaraje.png',
                    height: 250,
                    width: 250,
                  ),
                  TextField(
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.terciaryColor)),
                        hintText: 'Correo electronico'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    controller: _controllerPassword,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.terciaryColor)),
                        border: OutlineInputBorder(),
                        hintText: 'Contraseña'),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: CustomRoundedButtonWithIcon(
                      onPressed: () async {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      title: 'REGISTRAME',
                      icon: Icons.app_registration,
                      size: 120,
                      radius: 13,
                      buttonColor: Colors.mainColor,
                      splashColor: Colors.terciaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomRoundedButtonWithIcon(
                    onPressed: () async {
                      try {
                        await Auth()
                            .signInWithEmailAndPassword(
                                _controllerEmail.text, _controllerPassword.text)
                            .then((_) {
                          if (Auth().currentUser?.emailVerified == true) {
                            Navigator.pushReplacementNamed(context, '/');
                            toast("Bienvenido ${_controllerEmail.text}");
                            _controllerEmail.clear();
                            _controllerPassword.clear();
                          } else {
                            toast('Verifica tu correo');
                          }
                        });
                      } catch (AuthException) {
                        toast('El usuario no existe');
                      }
                    },
                    title: 'ENTRAR',
                    icon: Icons.login,
                    size: 170,
                    radius: 13,
                    buttonColor: Colors.mainColor,
                    splashColor: Colors.terciaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(233, 233, 233, 1),
                    onPrimary: Colors.secondaryColor,
                    minimumSize: const Size(double.infinity, 50)),
                icon: const FaIcon(FontAwesomeIcons.google),
                label: const Text("Signup with google"),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  var providerLoogin = provider.googleLoogin();
                  if (providerLoogin != null) {
                    Navigator.pushReplacementNamed(context, '/');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
