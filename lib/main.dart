import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/auth/login/login_page.dart';
import 'package:flutter_app/ui/pages/auth/register/register_page.dart';
import 'package:flutter_app/ui/pages/favorites/favorites_page.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/compare_car.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/selected_car/selected_car.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/simulate_race/simulate_race.dart';
import 'package:flutter_app/ui/pages/home/create_car/create_car.dart';
import 'package:flutter_app/ui/pages/home/home_page.dart';
import 'package:flutter_app/ui/pages/home/info_cars/info_car.dart';
import 'package:flutter_app/ui/pages/home/premium/payment/payment_page.dart';
import 'package:flutter_app/ui/pages/home/premium/premium_page.dart';
import 'package:flutter_app/ui/pages/home/search_car/search_car.dart';
import 'package:flutter_app/ui/pages/home/video_car/billboard_page.dart';
import 'package:flutter_app/ui/pages/profile/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'data/provider/google_sign_in.dart';
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
        theme: ThemeData(
          textTheme: TextTheme(
            displayLarge: GoogleFonts.montserrat(fontSize: 24),
            bodyLarge: GoogleFonts.montserrat(fontSize: 16),
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
          '/favorites': (context) => FavoritesPage(),
          '/search': (context) => SearchCarPage(),
          '/compare_car': (context) => CompareCarsPage(),
          '/selected_car': (context) => SelectedCarPage(),
          '/create_car': (context) => CreateCarPage(),
          '/race': (context) => SimulateRaceCar(),
          '/billboard': (context) => BillBoardPage(),
          '/premium': (context) => PremiumPage(),
          '/payment': (context) => PaymentPage(),
        },
      ));
}
