import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/CarModel.dart';

class Api {
  static Future<List<CarModel>> getCars() async {
    final response = await http.get(
      Uri.parse('https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getModel&model=11459'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Cars'] as List<dynamic>;
      print("HOOOOOOOOLA$data");
      return data.map((json) => CarModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }
}