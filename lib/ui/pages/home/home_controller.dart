
import 'package:flutter/cupertino.dart';

import '../../../data/services/firebase_services.dart';

class HomeController extends ChangeNotifier{

  final repository = FirebaseRepository();

  Future getCarsHome(){
    return repository.getAllCarsWithFavorite();
  }

}