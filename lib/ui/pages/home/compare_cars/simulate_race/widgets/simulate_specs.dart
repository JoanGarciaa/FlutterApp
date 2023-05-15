import 'package:flutter/material.dart';

import '../simulate_race.dart';

class SimulateSpecs extends StatelessWidget {
  final List<Cars> cars;
  final int i;
  const SimulateSpecs({Key? key, required this.cars, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          cars[i].name,
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
                value: cars[i].progress,
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
            Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    // '${(cars[i].progress * 100).toStringAsFixed(0)}%',
                      '${cars[i].speed.toStringAsFixed(0)} KM/H'),
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
                  '${cars[i].power} CV',
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
                  '${cars[i].weight} kg',
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
                  '${cars[i].torque} Nm',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
