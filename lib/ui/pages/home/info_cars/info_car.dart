import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/info_cars/info_car_controller.dart';
import 'package:flutter_app/ui/pages/home/info_cars/widgets/car_specs.dart';
import 'package:flutter_app/ui/pages/home/info_cars/widgets/like_button.dart';
import 'package:flutter_app/utils/style/font_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/car.dart';
import '../../../../data/services/firebase_services.dart';

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
  String formattedPrice = "";

  // bool isFavorite = false;
  late InfoCarController _controller;

  @override
  void initState() {
    _controller = InfoCarController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.afterFistLayout();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    car = arguments['car'];
    _controller.isFavoriteCar(car!.id);
    int? value = car!.price;
    String formattedPrices = value.toString();
    if (formattedPrices.length >= 7) {
      formattedPrice = formattedPrices.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})(\d{3})$'),
          (Match m) => '${m[1]}.${m[2]}.${m[3]}');
    } else {
      formattedPrice = formattedPrices.replaceAllMapped(
          RegExp(r'^(\d{1,3})(\d{3})+$'), (Match m) => '${m[1]}.${m[2]}');
    }
    return ChangeNotifierProvider<InfoCarController>(
      create: (_) => _controller,
      child: Scaffold(
        backgroundColor: Colors.mainColor,
        appBar: AppBar(
          title: const Text(
            "AutoSpecs",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.secondaryColor),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 5.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IndexedStack(index: index, children: [
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
                child: Column(
                  children: [
                    LikeButton(id: car!.id, email: currentUser!.email!),
                    SizedBox(
                      height: 70,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          index++;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
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
                child: Column(
                  children: [
                    LikeButton(id: car!.id, email: currentUser!.email!),
                    SizedBox(
                      height: 70,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ]),
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
                              "$formattedPrice €",
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
                      style: FontStyle.text16,
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
                    Text("Potencia: ${car!.cv.toString()} cv",
                        style: FontStyle.text16),
                    const SizedBox(height: 8),
                    Text("Motor: ${car!.engine.toString()}",
                        style: FontStyle.text16),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Velocidad máxima:', style: FontStyle.text16),
                        Container(
                          width: 200,
                          child: LinearPercentIndicator(
                            center: Text(
                              '${car!.max_speed} KM/H',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.secondaryColor),
                            ),
                            trailing: Icon(
                              Icons.local_fire_department_outlined,
                              color: Colors.deepPurple,
                            ),
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
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: CarSpecs(car: car!),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(233, 233, 233, 1),
                            onPrimary: Colors.secondaryColor,
                            minimumSize: const Size(double.infinity, 50)),
                        icon: const FaIcon(FontAwesomeIcons.car),
                        label: const Text(
                          "Comparar coches",
                        ),
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
      ),
    );
  }
}
