import 'package:flutter/cupertino.dart';

class FavoritesController extends ChangeNotifier{

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  set currentIndex(int value){
    _currentIndex = value;
  }

  bool isClicked = false;
  String formattedPrice = "";

  void handleClick() {
    isClicked = !isClicked;
    notifyListeners();
  }

}