import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildComparisonRow(
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
