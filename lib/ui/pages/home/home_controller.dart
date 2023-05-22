import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/provider/car_repository.dart';

import '../../../data/services/firebase_services.dart';

class HomeController extends ChangeNotifier {
  final repository = CarRepository();

  Future getCarsHome() async {
    return await repository.getAllCarsWithFavorite();
  }
}
