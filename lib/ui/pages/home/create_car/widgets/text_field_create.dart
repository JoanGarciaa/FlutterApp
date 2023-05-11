import 'package:flutter/material.dart';

class TextFieldCreate extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  const TextFieldCreate({Key? key, required this.text, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(text == 'URL IMAGEN'){
      return TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.terciaryColor)),
            labelText: text,
            suffixIcon: Icon(Icons.image),
            labelStyle: TextStyle(color: Colors.grey)),
      );
    }else{
      return TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.terciaryColor)),
            labelText: text,
            labelStyle: TextStyle(color: Colors.grey)),
      );
    }
  }
}
