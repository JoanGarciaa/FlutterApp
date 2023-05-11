import 'package:flutter/material.dart';

import '../../../../../data/models/car.dart';

class ItemCarSearch extends StatelessWidget {
  final List<Car> cars;
  final int index;
  const ItemCarSearch({Key? key, required this.cars, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
              cars[index].image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              cars[index].brand,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    cars[index].model,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
