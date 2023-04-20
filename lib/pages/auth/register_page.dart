import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/global_widgets/custom_rounded_button.dart';
import 'package:flutter_app/services/firebase_services.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerYears = TextEditingController();

  String? _selectedGender = 'Hombre';
  List<String> _genders = ['Hombre', 'Mujer', 'Otro'];

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
        elevation: 5.0,
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
              height: 100,
              width: 200,
              child: const Center(
                  child: Text(
                'REGISTRO',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, letterSpacing: 2),
              )),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.terciaryColor)),
                        hintText: 'Correo electronico'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: _controllerPassword,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.terciaryColor)),
                        hintText: 'Contraseña'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controllerUsername,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.terciaryColor)),
                        hintText: 'Nombre de usuario'),
                  ),
                ],
              ),
            ),
            Container(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'\d')),
                      ],
                      controller: _controllerYears,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          hintText: 'Edad'),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: DropdownButton<String>(
                          value: _selectedGender,
                          items: _genders.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomRoundedButtonWithIcon(
                    buttonColor: Colors.mainColor,
                    radius: 13,
                    splashColor: Colors.terciaryColor,
                    onPressed: () async {
                      try{
                        await Auth()
                            .createUserWithEmailAndPassword(
                            _controllerEmail.text, _controllerPassword.text)
                            .then((_) {
                          Auth().sendEmailVerification();
                          createUserDB(_controllerEmail.text, _controllerPassword.text, _controllerUsername.text, _controllerYears.text,_selectedGender!);
                          toast("Registro con éxito");
                          Navigator.pushNamed(context, '/login');
                        });
                      }catch(error){
                        print(error);
                        toast("No se ha podido crear el usuario");
                      }
                    },
                    title: 'Registro',
                    icon: Icons.app_registration,
                    size: 140,
                  ),
                  const SizedBox(
                    width: 30,
                    height: 10,
                  ),
                  CustomRoundedButtonWithIcon(
                    buttonColor: Colors.mainColor,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/login');
                    },
                    splashColor: Colors.terciaryColor,
                    title: 'Login',
                    icon: Icons.login,
                    radius: 13,
                    size: 140,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
