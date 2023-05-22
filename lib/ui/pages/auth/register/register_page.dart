import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/pages/auth/register/register_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../data/models/user_data.dart';
import '../../../../data/provider/user_repository.dart';
import '../../../../data/services/auth.dart';
import '../../../../data/services/firebase_services.dart';
import '../../../../utils/fonts/fonts.dart';
import '../../../../utils/global_widgets/custom_rounded_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final _controller = RegisterController();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerYears = TextEditingController();

  String? _selectedGender = 'Hombre';
  final List<String> _genders = ['Hombre', 'Mujer', 'Otro'];

  late UserData userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(
              height: 100,
              width: 200,
              child: Center(
                  child: Text(
                'REGISTRO',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    fontFamily: AppFonts.roboto),
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
                        labelText: "Correo electronico",
                        labelStyle: TextStyle(color: Colors.grey)),
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
                          borderSide: BorderSide(color: Colors.terciaryColor),
                        ),
                        labelText: "Contraseña",
                        labelStyle: TextStyle(color: Colors.grey)),
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
                        labelText: "Nombre de usuario",
                        labelStyle: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            SizedBox(
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
                          labelText: "Edad",
                          labelStyle: TextStyle(color: Colors.grey)),
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
                          underline: Container(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRoundedButtonWithIcon(
                  buttonColor: Colors.mainColor,
                  radius: 13,
                  splashColor: Colors.terciaryColor,
                  onPressed: () async {
                    _controller.createUser(
                        _controllerEmail.text,
                        _controllerPassword.text,
                        _controllerUsername.text,
                        _selectedGender!,
                        int.parse(_controllerYears.text),
                        context);
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
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  splashColor: Colors.terciaryColor,
                  title: 'Login',
                  icon: Icons.login,
                  radius: 13,
                  size: 140,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
