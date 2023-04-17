import 'package:http/http.dart' as http;

import '../models/post.dart';

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse('https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getModels&make=ford&year=2005&sold_in_us=1&body=SUV');
    var response = await client.get(uri);
    if (response.statusCode == 200) {

      var json = response.body;
      String nuevoTexto = json.substring(2, json.length);
      String nuevonuevoText = nuevoTexto.substring(0,nuevoTexto.length -2);

      return postFromJson(nuevonuevoText);
    }
  }
}
