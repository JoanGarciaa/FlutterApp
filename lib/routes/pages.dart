
import 'package:flutter/material.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/compare_car.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/selected_car/selected_car.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/simulate_race/simulate_race.dart';
import 'package:flutter_app/ui/pages/home/create_car/create_car.dart';
import 'package:flutter_app/ui/pages/home/video_car/billboard_page.dart';
import '../ui/pages/auth/login/login_page.dart';
import '../ui/pages/auth/register/register_page.dart';
import '../ui/pages/favorites/favorites_page.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/home/info_cars/info_car.dart';
import '../ui/pages/profile/profile_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes(){

  return {
    Routes.HOME:(_) => HomePage(),
    Routes.REGISTER:(_) => RegisterPage(),
    Routes.LOGIN:(_) => LoginPage(),
    Routes.FAVORITES:(_) => FavoritesPage(),
    Routes.PROFILE:(_) => ProfilePage(),
    Routes.INFOCAR:(_) => InfoCarPage(),
    Routes.COMPARE:(_) => CompareCarsPage(),
    Routes.SELECTED:(_) => SelectedCarPage(),
    Routes.RACE:(_) => SimulateRaceCar(),
    Routes.BILLBOARD:(_) => BillBoardPage(),
    Routes.CREATE:(_) => CreateCarPage(),
  };
}