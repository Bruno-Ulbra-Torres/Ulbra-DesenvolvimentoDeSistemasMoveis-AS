
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/character.dart';

class CharacterService{

  final String url =  "https://thronesapi.com/api/v2/Characters";


  Future<List<Character>> getCharacters() async {
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      var json = jsonDecode(response.body) as List;
      var listCharacters = json.map((item) => Character.fromJson(item)).toList();

      return listCharacters;

    }

    throw Exception("Error ao buscar os characters");
  }

}