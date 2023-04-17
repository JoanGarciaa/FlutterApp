import 'package:flutter/material.dart';

import '../models/CarModel.dart';
import '../services/Api.dart';

class Pantalla extends StatefulWidget {
  const Pantalla({Key? key}) : super(key: key);

  @override
  _PantallaState createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  late Future<List<CarModel>> _futureCars;

  @override
  void initState() {
    super.initState();
    _futureCars = Api.getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de carros'),
      ),
      body: FutureBuilder<List<CarModel>>(
        future: _futureCars,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cars = snapshot.data!;
            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return ListTile(
                  title: Text('${car.year} ${car.make} ${car.model}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
