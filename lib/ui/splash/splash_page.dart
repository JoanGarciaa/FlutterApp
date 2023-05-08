import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/splash/splash_controller.dart';
import 'package:lottie/lottie.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = SplashController();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _controller.isLoggedIn = true;
          _controller.userId = user.uid;
        });
        _controller.saveUserSession();
      } else {
        setState(() {
          _controller.isLoggedIn = false;
        });
      }
    });
    _controller.checkUserSession(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.splashColor,
      child: Column(
        children: [
          SizedBox(height: 400,),
          Center(
            child: Container(
              child:
              Lottie.asset('assets/lottie/carsplash.json', width: 300, height: 100),
            ),
          ),
        ],
      ),
    );
  }
}

