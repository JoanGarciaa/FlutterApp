import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth/register_page.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/auth/login_page.dart';
import 'package:flutter_app/pages/pantalla.dart';
import 'package:flutter_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/login',
        routes: {
          '/': (context) => const HomePage(),
          // '/add': (context) => const AddUserPage(),
          // '/modify': (context) => const ModifyUserPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
        },
      ));
}
