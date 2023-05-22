import 'package:flutter/material.dart';
import 'package:flutter_app/utils/style/font_style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../data/models/car.dart';

class CarSpecs extends StatelessWidget {
  final Car car;

  const CarSpecs({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Ver toda la información'),
      style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(233, 233, 233, 1),
          onPrimary: Colors.secondaryColor,
          minimumSize: const Size(double.infinity, 20)),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                  height: 300,
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey[800],
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            const Text(
                              'Especificaciones:',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text("Potencia: ${car.cv.toString()} cv",
                                style: FontStyle.text16),
                            const SizedBox(height: 8),
                            Text("Motor: ${car.engine.toString()}",
                                style: FontStyle.text16),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text('Velocidad máxima:',
                                    style: FontStyle.text16),
                                Container(
                                  width: 200,
                                  child: LinearPercentIndicator(
                                    center: Text(
                                      '${car.max_speed} KM/H',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.secondaryColor),
                                    ),
                                    trailing: Icon(
                                      Icons.local_fire_department_outlined,
                                      color: Colors.deepPurple,
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    lineHeight: 14.0,
                                    animation: true,
                                    percent: car.max_speed / 350,
                                    animationDuration: 1000,
                                    progressColor: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Peso: ${car.weight} kg',
                                style: FontStyle.text16),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Par motor: ${car.torque} Nm',
                                style: FontStyle.text16),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Año: 2021 ', style: FontStyle.text16),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Combustible: ${car.fuel} ',
                                style: FontStyle.text16),
                          ])));
            });
      },
    );
  }
}
