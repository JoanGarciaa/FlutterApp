import 'package:flutter/cupertino.dart';

class CreateCarController {
  TextEditingController? _controllerBrand,
      _controllerModel,
      _controllerYear,
      _controllerCV,
      _controllerFuel,
      _controllerMaxSpeed,
      _controllerEngine,
      _controllerPrice,
      _controllerNm,
      _controllerWeight,
      _controllerImage = TextEditingController();

  TextEditingController? get controllerBrand => _controllerBrand;

  TextEditingController? get controllerModel => _controllerModel;

  TextEditingController? get controllerYear => _controllerYear;

  TextEditingController? get controllerCV => _controllerCV;

  TextEditingController? get controllerFuel => _controllerFuel;

  TextEditingController? get controllerMaxSpeed => _controllerMaxSpeed;

  TextEditingController? get controllerEngine => _controllerEngine;

  TextEditingController? get controllerPrice => _controllerPrice;

  TextEditingController? get controllerNm => _controllerNm;

  TextEditingController? get controllerWeight => _controllerWeight;

  TextEditingController? get controllerImage => _controllerImage;
}
