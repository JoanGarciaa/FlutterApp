import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/global_widgets/custom_rounded_button.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

import '../../services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(

              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controllerEmail,
                    decoration:
                        const InputDecoration(hintText: 'Correo electronico'),
                  ),
                  TextField(
                    controller: _controllerPassword,
                    decoration: const InputDecoration(hintText: 'Contraseña'),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              child: Column(
                children: <Widget>[
                  CustomRoundedButtonWithIcon(
                    radius: 13,
                    splashColor: Colors.white60,
                    onPressed: () async {
                      await Auth()
                          .createUserWithEmailAndPassword(
                              _controllerEmail.text, _controllerPassword.text)
                          .then((_) {
                        Auth().sendEmailVerification();
                        Navigator.pushNamed(context, '/login');
                      });
                    },
                    title: 'Registro', icon: Icons.app_registration,
                  ),
                  const SizedBox(
                    height:10 ,
                  ),
                  CustomRoundedButtonWithIcon(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/login');
                      },
                      title: 'Login', icon: Icons.login, radius: 13,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
