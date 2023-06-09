import 'package:flutter/material.dart';

class TextFormFieldPayment extends StatelessWidget {
  final String label;
  final String valueError;

  const TextFormFieldPayment(
      {Key? key, required this.label, required this.valueError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.terciaryColor,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.terciaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.terciaryColor),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return valueError;
        }
        return null;
      },
    );
  }
}
