import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/compare_cars/selected_car/widgets/select_car.dart';

import '../../../../../data/models/car.dart';
import '../../../../../data/services/firebase_services.dart';
import '../../../../../utils/fonts/fonts.dart';

class SelectedCarPage extends StatefulWidget {
  const SelectedCarPage({Key? key}) : super(key: key);

  @override
  State<SelectedCarPage> createState() => _SelectedCarPageState();
}

class _SelectedCarPageState extends State<SelectedCarPage> {
  Car? car1;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    car1 = arguments['car'];

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://cdn.autobild.es/sites/navi.axelspringer.es/public/media/image/2018/01/mazda-rx-7_4.jpg"),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              child: Center(
                  child: Text(
                    'Escoje un coche',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        fontFamily: AppFonts.roboto),
                  )),
            ),
            SelectCar(car1: car1!,)
          ],
        ),
      ),
    );
  }
}
