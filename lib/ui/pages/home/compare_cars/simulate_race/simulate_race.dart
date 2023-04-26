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

class _SimulateRaceCarState extends State<SimulateRaceCar> {
  Car? car1;
  Car? car2;
  List<Cars> cars = [
    Cars(
        name: "Ferrari",
        power: 800,
        weight: 1400,
        torque: 718,
        speed: 0,
        progress: 0),
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
      body: Column(
        children: [
          for (int i = 0; i < cars.length; i++)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(car1!.brand),
                  Text("${cars[i].speed.toStringAsFixed(0)} km/h"),
                  Text("${(cars[i].progress * 100).toStringAsFixed(0)}%"),
                ],
              ),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isRacing ? null : startRace,
            child: Text('Iniciar carrera'),
          ),
        ],
      ),
    );
  }

  void startRace() {
    isRacing = true;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      for (int i = 0; i < cars.length; i++) {
        double acceleration = (cars[i].power * 0.7355) / cars[i].weight;
        double friction = (9.81 * cars[i].weight * 0.3) / cars[i].weight;
        double netForce = acceleration - friction;
        double accelerationDueToGravity = 9.81;
        double slopeForce = sin(atan(netForce / accelerationDueToGravity));
        double torqueForce = cars[i].torque / cars[i].weight;
        double totalForce = slopeForce + torqueForce;
        cars[i].speed += totalForce * 5;
        cars[i].progress += cars[i].speed / 2000;
        if (cars[i].progress >= 1) {
          timer.cancel();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Resultado'),
              content: Text('${cars[i].name} ha ganado la carrera'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Salir'),
                ),
              ],
            ),
          );
        }
      }
      setState(() {});
    });
  }

  void resetRace() {
    for (int i = 0; i < cars.length; i++) {
      cars[i].speed = 0;
      cars[i].progress = 0;
    }
    isRacing = false;
  }
}
