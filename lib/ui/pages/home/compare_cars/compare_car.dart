import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/simulate_race/simulate_race.dart';
import 'package:flutter_app/utils/global_widgets/custom_rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String formattedPrice01 = "";
  String formattedPrice02 = "";
  @override
  void initState() {
    super.initState();
    _fetchCars();
  }
  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
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
          RegExp(r'^(\d{1,3})(\d{3})+$'),
              (Match m) => '${m[1]}.${m[2]}');
    }
    if (formattedPrice2.length >= 7) {
      formattedPrice02 = formattedPrice2.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})(\d{3})$'),
              (Match m) => '${m[1]}.${m[2]}.${m[3]}');
    } else {
      formattedPrice02 = formattedPrice2.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})+$'),
              (Match m) => '${m[1]}.${m[2]}');
    }
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
                      '$formattedPrice01 €',
                      car2 != null ? '$formattedPrice02 €' : "X",
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
                      car2 != null ? '${car2!.max_speed.toString()} km/h' : "X",
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
                    const SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: CustomRoundedButtonWithIcon(onPressed: () async {
                        car2 != null ? await Navigator.pushNamed(context, '/race',
                            arguments: {
                              "car": car1,
                              "car2": car2
                            }) : toast("Necesitas que hayan dos coches");
                        
                        
                      }, title: 'Simular Carrera',
                      icon: Icons.flag,
                      size: 20,
                      ),
                    ),
                    const SizedBox(height: 50,)
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
