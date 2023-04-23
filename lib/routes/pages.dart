
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/favorites/favorites_page.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/home/info_cars/info_car.dart';
import 'package:flutter_app/pages/profile/profile_page.dart';
import 'package:flutter_app/routes/routes.dart';

import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes(){

  return {
    Routes.HOME:(_) => HomePage(),
    Routes.REGISTER:(_) => RegisterPage(),
    Routes.LOGIN:(_) => LoginPage(),
    Routes.FAVORITES:(_) => FavoritesPage(),
    Routes.PROFILE:(_) => ProfilePage(),
    Routes.INFOCAR:(_) => InfoCarPage(),
  };
}