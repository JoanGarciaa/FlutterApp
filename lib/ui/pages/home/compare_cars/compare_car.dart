import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/models/car.dart';
import '../../../../data/services/firebase_services.dart';

class CompareCarsPage extends StatefulWidget {
  const CompareCarsPage({Key? key}) : super(key: key);

  @override
  _CompareCarsPageState createState() => _CompareCarsPageState();
}

class _CompareCarsPageState extends State<CompareCarsPage> {
  Car? car1;
  Car? car2;

  @override
  void initState() {
    super.initState();
    _fetchCars();
  }

  Future<void> _fetchCars() async {
    // Obtener información del primer coche
    const car1Id = '1001';
    final car1Data = await getCar(car1Id);
    print('bondia ${car1Data?.brand}');
    // setState(() {
    //   car2 = Car(
    //     id: '1001',
    //     brand: data['brand'],
    //     model: data!['model'],
    //     image: data!['image'],
    //     image2: data!['image2'],
    //     max_speed: data!['max_speed'],
    //     cv: data!['cv'],
    //     price: data!['price'],
    //     fuel: data!['fuel'],
    //     engine: data!['engine'],
    //     favorite: data!['favorite'],
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    car1 = arguments['car'];
    car2 = arguments['car2'];
    print(car1?.brand);
    print(car2?.brand);

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        car1!.brand,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[900],
                        ),
                      ),
                      Text(
                        car1!.model,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        height: 100.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(car1!.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        car2 != null ? car2!.brand : "Escoge",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[900],
                        ),
                      ),
                      Text(
                        car2 != null ? car2!.model : "Un coche",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        child: Container(
                          height: 100.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                car2 != null
                                    ? car2!.image
                                    : "https://cdn-icons-png.flaticon.com/512/89/89102.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/selected_car',
                              arguments: {
                                "car": car1,
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildComparisonRow(
                      'Precio',
                      '${car1!.price.toString()}.000 €',
                      car2 != null ? '${car2!.price}.000 €' : "X",
                      Colors.deepPurple[900]!,
                    ),
                    _buildComparisonRow(
                      'Motor',
                      car1!.engine,
                      car2 != null ? car2!.engine : "X",
                      Colors.deepPurple[900]!,
                    ),
                    _buildComparisonRow(
                      'Potencia',
                      '${car1!.cv.toString()} cv',
                      car2 != null ? '${car2!.cv.toString()} cv' : "X",
                      Colors.deepPurple[900]!,
                    ),
                    _buildComparisonRow(
                      'Velocidad Máxima',
                      '${car1!.max_speed.toString()} km/h',
                      car2 != null ? '${car2!.max_speed.toString()} cv' : "X",
                      Colors.deepPurple[900]!,
                    ),
                    _buildComparisonRow(
                      'Combustible',
                      car1!.fuel,
                      car2 != null ? car2!.fuel : "X",
                      Colors.deepPurple[900]!,
                    ),
                    _buildComparisonRow(
                      'Torque',
                      '${car1!.cv.toString()} Nm',
                      car2 != null ? '${car2!.cv} Nm' : "X",
                      Colors.deepPurple[900]!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
      String label, String value1, String value2, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(child: Text(label, style: const TextStyle(fontSize: 17))),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      child: Center(
                    child: Text(
                      value1,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  )),
                ),
                Container(
                    child: Image.asset(
                  'assets/images/versus2.png',
                  width: 24,
                  height: 24,
                )),
                Expanded(
                    child: Container(
                  child: Center(
                    child: Text(
                      value2,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: color,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            height: 5,
            color: Colors.terciaryColor,
          )
        ],
      ),
    );
  }
}
