import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier{
  bool isLoggedIn = false;
  String userId = '';

  Future<void> saveUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<void> checkUserSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUserId = prefs.getString('userId');
    if (savedUserId != null) {
      isLoggedIn = true;
      userId = savedUserId;
      Navigator.pushReplacementNamed(context, '/');
      notifyListeners();
    }
  }
}