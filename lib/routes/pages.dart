import 'package:flutter/material.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/compare_car.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/selected_car/selected_car.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/simulate_race/simulate_race.dart';
import 'package:flutter_app/ui/pages/home/create_car/create_car.dart';
import 'package:flutter_app/ui/pages/home/premium/payment/payment_page.dart';
import 'package:flutter_app/ui/pages/home/premium/premium_page.dart';
import 'package:flutter_app/ui/pages/home/search_car/search_car.dart';
import 'package:flutter_app/ui/pages/home/video_car/billboard_page.dart';
import 'package:flutter_app/ui/splash/splash_page.dart';
import '../ui/pages/auth/login/login_page.dart';
import '../ui/pages/auth/register/register_page.dart';
import '../ui/pages/favorites/favorites_page.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/home/info_cars/info_car.dart';
import '../ui/pages/profile/profile_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => SplashPage(),
    Routes.HOME: (_) => HomePage(),
    Routes.LOGIN: (_) => LoginPage(),
    Routes.REGISTER: (_) => RegisterPage(),
    Routes.INFOCAR: (_) => InfoCarPage(),
    Routes.PROFILE: (_) => ProfilePage(),
    Routes.FAVORITES: (_) => FavoritesPage(),
    Routes.SEARCH: (_) => SearchCarPage(),
    Routes.COMPARE: (_) => CompareCarsPage(),
    Routes.SELECTED: (_) => SelectedCarPage(),
    Routes.CREATE: (_) => CreateCarPage(),
    Routes.RACE: (_) => SimulateRaceCar(),
    Routes.BILLBOARD: (_) => BillBoardPage(),
    Routes.PREMIUM: (_) => PremiumPage(),
    Routes.PAYMENT: (_) => PaymentPage(),
  };
}
