
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/provider/car_repository.dart';

import '../../../../data/models/car.dart';

class SearchCarController extends ChangeNotifier{

  final repository = CarRepository();

  Future<List<Car>>getCarsSearch(String itemSelected) async {
    return await repository.getAllCarsForSearch2(itemSelected);
  }

}