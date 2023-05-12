import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/ui/pages/home/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../data/provider/google_sign_in.dart';
import '../../../../data/services/auth.dart';
import '../../../../utils/global_widgets/custom_rounded_button.dart';
import 'login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final _controller = LoginController();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                      _controller.loginUser(_controllerEmail.text, _controllerPassword.text, context);
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
                  _controller.googleLogin(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
