import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/create_car/create_car_controller.dart';
import 'package:flutter_app/ui/pages/home/create_car/widgets/form_create_car.dart';
import 'package:flutter_app/ui/pages/home/create_car/widgets/text_field_create.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class CreateCarPage extends StatefulWidget {
  const CreateCarPage({Key? key}) : super(key: key);

  @override
  State<CreateCarPage> createState() => _CreateCarPageState();
}

class _CreateCarPageState extends State<CreateCarPage> {
  final _controller = CreateCarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FormCreateCar(),
      ),
    );
  }
}
