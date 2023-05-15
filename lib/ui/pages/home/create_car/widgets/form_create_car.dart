import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/create_car/create_car_controller.dart';
import 'package:flutter_app/ui/pages/home/create_car/widgets/text_field_create.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class FormCreateCar extends StatelessWidget {
  const FormCreateCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = CreateCarController();
    return Column(
      children: [
        Container(
          child: const Center(
              child: Text(
                'Enseñanos que sabes',
                style: TextStyle(fontSize: 26, letterSpacing: 1.0),
              )),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          child: Row(
            children: [
              Expanded(
                child: TextFieldCreate(
                  text: 'Marca',
                  controller: _controller.controllerBrand,
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: TextFieldCreate(
                  text: 'Modelo',
                  controller: _controller.controllerModel,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          child: Row(
            children: [
              Expanded(
                child: TextFieldCreate(
                  text: 'Año',
                  controller: _controller.controllerYear,
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: TextFieldCreate(
                  text: 'Potencia',
                  controller: _controller.controllerYear,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          child: Row(
            children: [
              Expanded(
                child: TextFieldCreate(
                  text: 'Combustible',
                  controller: _controller.controllerFuel,
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: TextFieldCreate(
                  text: 'Velocidad Máxima',
                  controller: _controller.controllerMaxSpeed,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          child: Row(
            children: [
              Expanded(
                child: TextFieldCreate(
                  text: 'Motor',
                  controller: _controller.controllerEngine,
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: TextFieldCreate(
                  text: 'Precio',
                  controller: _controller.controllerPrice,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          child: Row(
            children: [
              Expanded(
                child: TextFieldCreate(
                  text: 'Par motor',
                  controller: _controller.controllerNm,
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: TextFieldCreate(
                  text: 'Peso',
                  controller: _controller.controllerWeight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          child: Row(
            children: [
              Expanded(
                child: TextFieldCreate(
                  text: 'URL IMAGEN',
                  controller: _controller.controllerImage,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: RoundedButtonWithIcon(
            title: 'Crear coche',
            onPressed: () {},
            icon: Icons.add,
            buttonColor: Colors.terciaryColor,
          ),
        )
      ],
    );
  }
}
