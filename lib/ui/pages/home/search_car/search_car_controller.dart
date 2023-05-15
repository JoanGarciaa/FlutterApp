
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/provider/car_repository.dart';

import '../../../../data/models/car.dart';

class SearchCarController extends ChangeNotifier{

  final repository = CarRepository();

  static const List<String> _list = <String>[
    'Ver todos', 'Audi', 'BMW', 'Ford', 'Ferrari', 'Lexus', 'Lamborguini', 'Mclaren', 'Mercedes', 'Nissan', 'Porsche', 'Volkswagen'
  ];

  List<String> get list => _list;

  String? _itemSelected = "";
  String? get itemSelected => _itemSelected;

  setItemSelected(String item){
    _itemSelected = item;
  }

  Future<List<Car>>getCarsSearch(String itemSelected) async {
    return await repository.getAllCarsForSearch(itemSelected);
  }

}