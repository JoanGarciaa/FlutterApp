
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/routes/routes.dart';

import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes(){

  return {
    Routes.HOME:(_) => HomePage(),
    Routes.REGISTER:(_) => RegisterPage(),
    Routes.LOGIN:(_) => LoginPage(),
  };
}