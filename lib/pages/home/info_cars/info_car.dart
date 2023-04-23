import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InfoCarPage extends StatefulWidget {
  const InfoCarPage({Key? key}) : super(key: key);

  @override
  State<InfoCarPage> createState() => _InfoCarPageState();
}

class _InfoCarPageState extends State<InfoCarPage> {
  TextEditingController nameController = TextEditingController(text: "");
  String brand = "";
  String fuel = "";
  String image = "";
  int max_speed = 0;
  String model = "";
  int cv = 0;
  String engine = "";
  String uid = "";
  double value = 0.0;


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    brand = arguments['brand'];
    uid = arguments['id'];
    fuel = arguments['fuel'];
    image = arguments['image'];
    max_speed = arguments['max_speed'];
    model = arguments['model'];
    cv = arguments['cv'];
    engine = arguments['engine'];
    value = max_speed / 300;
    String decimalString = value.toString().split('.')[1];
    String firstDecimal = decimalString.substring(0, 1);
    double result = double.parse('0.$firstDecimal');
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[800],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    model,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tipo de combustible:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fuel,
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
                        '$max_speed \n km/h',textAlign: TextAlign.center,style: TextStyle(color: Colors.secondaryColor),
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
