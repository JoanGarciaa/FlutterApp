import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/car.dart';

class ImagesCompare extends StatelessWidget {
  final Car? car1;
  final Car? car2;

  const ImagesCompare({Key? key, required this.car1, required this.car2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  Navigator.pushNamed(context, '/selected_car', arguments: {
                    "car": car1,
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
