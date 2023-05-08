import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/create_car/create_car_controller.dart';
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
        child: Column(
          children: [
            Container(
              child: const Center(
                  child: Text(
                    'Enseñanos que sabes',
                    style: TextStyle(fontSize: 26, letterSpacing: 1.0),
                  )),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerBrand,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Marca",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerModel,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Modelo",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerYear,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Año",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerCV,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Potencia",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerFuel,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Combustible",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerMaxSpeed,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Velocidad Máxima",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerEngine,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Motor",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerPrice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Precio",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerNm,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Par motor",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "Peso",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller.controllerImage,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.terciaryColor)),
                          labelText: "URL IMAGEN",
                          labelStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              child: RoundedButtonWithIcon(title: 'Crear coche', onPressed: (){

              }, icon: Icons.add,buttonColor: Colors.terciaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
