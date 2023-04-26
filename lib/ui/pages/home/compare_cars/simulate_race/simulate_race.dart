import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../data/models/car.dart';

class Cars {
  String name;
  int power; // CV
  int weight; // kg
  int torque; // Nm
  double speed; // km/h
  double progress; // Valor entre 0 y 1

  Cars({
    required this.name,
    required this.power,
    required this.weight,
    required this.torque,
    required this.speed,
    required this.progress,
  });
}

class SimulateRaceCar extends StatefulWidget {
  const SimulateRaceCar({Key? key}) : super(key: key);

  @override
  _SimulateRaceCarState createState() => _SimulateRaceCarState();
}

class _SimulateRaceCarState extends State<SimulateRaceCar>
    with SingleTickerProviderStateMixin {
  Car? car1;
  Car? car2;


  List<Cars> cars = [
    Cars(
        name: "Porsche",
        power: 300,
        weight: 1640,
        torque: 750,
        speed: 0,
        progress: 0),
    Cars(
        name: "McLaren",
        power: 675,
        weight: 1311,
        torque: 700,
        speed: 0,
        progress: 0),
  ];

  bool isRacing = false;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    car1 = arguments['car'];
    car2 = arguments['car2'];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AutoSpecs",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.mainColor,
              Colors.secondaryColor,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              car1!.brand,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 300,
                                  child: LinearProgressIndicator(
                                    value: car1!.progress,
                                    backgroundColor: Colors.grey[400],
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      Colors.terciaryColor,
                                    ),
                                  ),
                                ),
                                const Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.flag,
                                        color: Colors.green,
                                        size: 40,
                                      )),
                                ),
                                Positioned.fill(child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    // Text("${(cars[i].progress * 100).toStringAsFixed(0)}%"),
                                    '${car1!.speed.toStringAsFixed(0)} KM/H'
                                  ),
                                ))
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Potencia',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${car1!.cv} CV',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Peso',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${car1!.cv} kg',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Par',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${car1!.cv} Nm',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              car2!.brand,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 300,
                                  child: LinearProgressIndicator(
                                    value: car2!.progress,
                                    backgroundColor: Colors.grey[400],
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      Colors.terciaryColor,
                                    ),
                                  ),
                                ),
                                const Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.flag,
                                        color: Colors.green,
                                        size: 40,
                                      )),
                                ),
                                Positioned.fill(child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    // Text("${(cars[i].progress * 100).toStringAsFixed(0)}%"),
                                      '${car2!.speed.toStringAsFixed(0)} KM/H'
                                  ),
                                ))
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Potencia',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${car2!.cv} CV',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Peso',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${car2!.cv} kg',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Par',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${car2!.cv} Nm',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: isRacing ? null : startRace,
                child: const Text('Iniciar carrera'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  elevation: MaterialStateProperty.all<double>(5),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startRace() {
    isRacing = true;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      for (int i = 0; i < cars.length; i++) {
        double accelerationDueToGravity = 9.81;

        double accelerationCar1 = (car1!.cv * 0.7355) / car1!.weight;
        double frictionCar1 = (9.81 * car1!.weight * 0.3) / car1!.weight;
        double netForceCar1 = accelerationCar1 - frictionCar1;
        double slopeForceCar1 = sin(atan(netForceCar1 / accelerationDueToGravity));
        double torqueForceCar1 = car1!.torque / car1!.weight;
        double totalForceCar1 = slopeForceCar1 + torqueForceCar1;

        car1!.speed += totalForceCar1 * 9.5;
        car1!.progress += car1!.speed / 7000;

        double accelerationCar2 = (car2!.cv * 0.7355) / car2!.weight;
        double frictionCar2 = (9.81 * car2!.weight * 0.3) / car2!.weight;
        double netForceCar2 = accelerationCar2 - frictionCar2;
        double slopeForceCar2 = sin(atan(netForceCar2 / accelerationDueToGravity));
        double torqueForceCar2 = car2!.torque / car2!.weight;
        double totalForceCar2 = slopeForceCar2 + torqueForceCar2;

        double acceleration = (cars[i].power * 0.7355) / cars[i].weight;
        double friction = (9.81 * cars[i].weight * 0.3) / cars[i].weight;
        double netForce = acceleration - friction;
        double slopeForce = sin(atan(netForce / accelerationDueToGravity));
        double torqueForce = cars[i].torque / cars[i].weight;
        double totalForce = slopeForce + torqueForce;
        cars[i].speed += totalForce * 9.5;
        cars[i].progress += cars[i].speed / 7000;

        car2!.speed += totalForceCar2 * 9.5;
        car2!.progress += car2!.speed / 7000;

          if (car1!.progress >= 1 || car2!.progress >= 1) {
            timer.cancel();
            showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: const Text('Resultado'),
                    content: Text('Tenemos ganador'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          resetRace();
                          Navigator.pop(context);
                        },
                        child: const Text('Salir'),
                      ),
                    ],
                  ),
            );
            setState(() {});
          }
        }
    });
  }

  void resetRace() {
      car1!.speed = 0;
      car1!.progress = 0;
      car2!.speed = 0;
      car2!.progress = 0;

    isRacing = false;
  }
}
