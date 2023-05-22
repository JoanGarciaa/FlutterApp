import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/compare_car_controller.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/simulate_race/simulate_race.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/widgets/builComparasionRow.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/widgets/compare_specs.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/widgets/images_compare.dart';
import 'package:flutter_app/utils/global_widgets/custom_rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/models/car.dart';
import '../../../../data/services/firebase_services.dart';
import '../../../../utils/methods/methods.dart';

class CompareCarsPage extends StatefulWidget {
  const CompareCarsPage({Key? key}) : super(key: key);

  @override
  _CompareCarsPageState createState() => _CompareCarsPageState();
}

class _CompareCarsPageState extends State<CompareCarsPage> {
  Car? car1;
  Car? car2;
  String formattedPrice01 = "";
  String formattedPrice02 = "";
  late CompareCarController _controller;

  @override
  void initState() {
    _controller = CompareCarController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.afterFistLayout();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    car1 = arguments['car'];
    car2 = arguments['car2'];
    int? value1 = car1!.price;
    int? value2 = car2?.price;
    String formattedPrice1 = value1.toString();
    String formattedPrice2 = value2.toString();

    if (formattedPrice1.length >= 7) {
      formattedPrice01 = formattedPrice1.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})(\d{3})$'),
          (Match m) => '${m[1]}.${m[2]}.${m[3]}');
    } else {
      formattedPrice01 = formattedPrice1.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})+$'), (Match m) => '${m[1]}.${m[2]}');
    }
    if (formattedPrice2.length >= 7) {
      formattedPrice02 = formattedPrice2.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})(\d{3})$'),
          (Match m) => '${m[1]}.${m[2]}.${m[3]}');
    } else {
      formattedPrice02 = formattedPrice2.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})+$'), (Match m) => '${m[1]}.${m[2]}');
    }
    return Scaffold(
      backgroundColor: Colors.mainColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.secondaryColor),
        title: const Text(
          "AutoSpecs",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ImagesCompare(
                car1: car1,
                car2: car2,
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    buildComparisonRow(
                      'Precio',
                      '$formattedPrice01 €',
                      car2 != null ? '$formattedPrice02 €' : "X",
                      Colors.deepPurple[900]!,
                    ),
                    buildComparisonRow(
                      'Motor',
                      car1!.engine,
                      car2 != null ? car2!.engine : "X",
                      Colors.deepPurple[900]!,
                    ),
                    buildComparisonRow(
                      'Potencia',
                      '${car1!.cv.toString()} cv',
                      car2 != null ? '${car2!.cv.toString()} cv' : "X",
                      Colors.deepPurple[900]!,
                    ),
                    buildComparisonRow(
                      'Velocidad Máxima',
                      '${car1!.max_speed.toString()} km/h',
                      car2 != null ? '${car2!.max_speed.toString()} km/h' : "X",
                      Colors.deepPurple[900]!,
                    ),
                    buildComparisonRow(
                      'Combustible',
                      car1!.fuel,
                      car2 != null ? car2!.fuel : "X",
                      Colors.deepPurple[900]!,
                    ),
                    buildComparisonRow(
                      'Torque',
                      '${car1!.cv.toString()} Nm',
                      car2 != null ? '${car2!.cv} Nm' : "X",
                      Colors.deepPurple[900]!,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: CustomRoundedButtonWithIcon(
                        onPressed: () async {
                          if (_controller.user.premium) {
                            car2 != null
                                ? await Navigator.pushNamed(context, '/race',
                                    arguments: {"car": car1, "car2": car2})
                                : Methods.toast(
                                    "Necesitas que hayan dos coches", context);
                          } else {
                            Methods.toast(
                                'Necesitas ser premium para acceder a esta funcion',
                                context);
                          }
                        },
                        title: 'Simular Carrera',
                        icon: Icons.flag,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
