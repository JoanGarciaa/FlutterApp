import 'dart:async';
import 'dart:math';
import 'package:flutter_app/ui/pages/home/compare_cars/simulate_race/widgets/simulate_specs.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart'; // Import stop_watch_timer

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
  late Car car1;
  late Car car2;

  late List<Cars> cars = [
    Cars(
        name: car1.brand,
        power: car1.cv,
        weight: car1.weight,
        torque: car1.torque,
        speed: 0,
        progress: 0),
    Cars(
        name: car2.brand,
        power: car2.cv,
        weight: car2.weight,
        torque: car2.torque,
        speed: 0,
        progress: 0),
  ];

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  bool isRacing = false;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    car1 = arguments['car'];
    car2 = arguments['car2'];

    return Scaffold(
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
            for (int i = 0; i < cars.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SimulateSpecs(cars: cars,i: i,),
                  ),
                ),
              ),
            SizedBox(height: 20,),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: 0,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime = StopWatchTimer.getDisplayTime(value!);
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: isRacing ? null : startRace,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  elevation: MaterialStateProperty.all<double>(5),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const Text('Iniciar carrera'),
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
        _stopWatchTimer.onStartTimer();
        const double rollingResistance = 0.01;
        const double dragCoefficient = 0.3;
        const double airDensity = 1.2;
        const double frontalArea = 2.5;
        const double deltaTime = 0.1;
        const double trackLength = 500.0;
        final double engineForce = cars[i].power * 95;
        final double rollingResistanceForce =
            rollingResistance * cars[i].weight * 9.81;
        final double dragForce = 0.5 *
            dragCoefficient *
            airDensity *
            cars[i].speed *
            cars[i].speed *
            frontalArea;
        final double netForce =
            engineForce - rollingResistanceForce - dragForce;
        final double acceleration = netForce / cars[i].weight;
        cars[i].speed += acceleration * deltaTime;
        cars[i].progress += cars[i].speed * deltaTime / trackLength;
        if (cars[i].progress >= 1) {
          _stopWatchTimer.onStopTimer();
          timer.cancel();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Resultado'),
              content: Text('${cars[i].name} ha ganado la carrera'),
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
        }
      }
      setState(() {});
    });
  }

  void resetRace() {
    for (int i = 0; i < 2; i++) {
      cars[i].speed = 0;
      cars[i].progress = 0;
    }
    isRacing = false;
  }

  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }
}