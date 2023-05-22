import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/provider/car_repository.dart';

import '../../../data/models/car.dart';

class FavoritesController extends ChangeNotifier {
  final repository = CarRepository();

  int _currentIndex = 1;

  int get currentIndex => _currentIndex;
  bool isClicked = false;
  String formattedPrice = "";

  set currentIndex(int value) {
    _currentIndex = value;
  }

  void handleClick() {
    isClicked = !isClicked;
    notifyListeners();
  }

  Future getValueGarage() async {
    return await repository.getTotalValueGarage();
  }

  Future getMyFavoriteCars() async {
    return await repository.getMyFavoriteCars();
  }
}
