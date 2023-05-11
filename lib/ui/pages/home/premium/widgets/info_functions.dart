import 'package:flutter/material.dart';

class InfoFunctions extends StatelessWidget {
  const InfoFunctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(' - Modificaciones de coches'),
        SizedBox(
          height: 10,
        ),
        Text(' - Crear coches para la comunidad'),
        SizedBox(
          height: 10,
        ),
        Text(' - Simulacion automatica de carreras'),
        SizedBox(
          height: 10,
        ),
        Text(' - Modificar el perfil'),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
