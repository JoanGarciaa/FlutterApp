import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../data/models/car.dart';

class InfoCarPage extends StatefulWidget {
  const InfoCarPage({Key? key}) : super(key: key);

  @override
  @override
  State<InfoCarPage> createState() => _InfoCarPageState();
}

class _InfoCarPageState extends State<InfoCarPage> {
  TextEditingController nameController = TextEditingController(text: "");
  Car? car;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    car = arguments['car'];
    return Scaffold(
      backgroundColor: Colors.mainColor,
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
                  height: 300,
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
                  height: 300,
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${car!.price}.000 €",
                            style: const TextStyle(
                              color: Colors.mainColor,
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
                  Row(
                    children: [
                      const Text(
                        'Velocidad máxima:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        width: 200,
                        child: LinearPercentIndicator(
                          center: Text(
                            '${car!.max_speed} KM/H',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.secondaryColor),
                          ),
                          trailing: Icon(Icons.local_fire_department_outlined, color: Colors.deepPurple,),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          lineHeight: 14.0,
                          animation: true,
                          percent: car!.max_speed / 350,
                          animationDuration: 1000,
                          progressColor: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(height: 40,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(233, 233, 233, 1),
                          onPrimary: Colors.secondaryColor,
                          minimumSize: const Size(double.infinity, 50)),
                      icon: const FaIcon(FontAwesomeIcons.car),
                      label: const Text("Comparar coches",),
                      onPressed: () {
                        Navigator.pushNamed(context, '/compare_car',
                        arguments: {
                          "car": car,
                        });
                        setState(() {});
                      },
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
