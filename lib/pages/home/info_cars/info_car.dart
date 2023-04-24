import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../models/car.dart';

class InfoCarPage extends StatefulWidget {
  const InfoCarPage({Key? key}) : super(key: key);

  @override
  @override
  State<InfoCarPage> createState() => _InfoCarPageState();
}

class _InfoCarPageState extends State<InfoCarPage> {
  TextEditingController nameController = TextEditingController(text: "");
  Car? car;
  double value = 0.0;
  int index = 0;


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    car = arguments['car'];
    value = car!.max_speed / 300;
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IndexedStack(
              index: index,
              children: [
                Container(
                  height: 400,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    image: DecorationImage(
                      image: NetworkImage(car!.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: IconButton(onPressed: () {
                    setState(() {
                      index ++;
                      print(index);
                    });
                  },
                    icon: const Icon(
                      Icons.arrow_forward, color: Colors.terciaryColor,
                      size: 40,),),
                ),
                Container(
                  height: 400,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    image: DecorationImage(
                      image: NetworkImage(car!.image2),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: IconButton(onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                    icon: const Icon(
                      Icons.arrow_forward, color: Colors.terciaryColor,
                      size: 40,),),
                ),
              ]
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[800],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        car!.brand,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '83,455€',
                            style: TextStyle(
                              color: Colors.terciaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    car!.model,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
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
                  Text(
                    "Potencia: ${car!.cv.toString()} cv",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Motor: ${car!.engine.toString()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tipo de combustible: ${car!.fuel}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Velocidad máxima:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: 100,
                    height: 100,
                    child: CircularPercentIndicator(
                      center: Text(
                        '${car!.max_speed} \n km/h',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      radius: 40.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: value,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
