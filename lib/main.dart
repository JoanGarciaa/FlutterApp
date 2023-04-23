import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth/register_page.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/auth/login_page.dart';
import 'package:flutter_app/pages/home/info_cars/info_car.dart';
import 'package:flutter_app/pages/profile/profile_page.dart';
import 'package:flutter_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'fonts/fonts.dart';

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
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: AppFonts.regular.copyWith(fontSize: 24),
            bodyText1: AppFonts.regular.copyWith(fontSize: 16),
          ),
        ),
        title: 'Flutter Demo',
        initialRoute: '/login',
        routes: {
          '/': (context) => const HomePage(),
          // '/add': (context) => const AddUserPage(),
          // '/modify': (context) => const ModifyUserPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/info-car': (context) => InfoCarPage(),
          '/profile': (context) => ProfilePage(),
        },
      ));
}
