import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mynews/models/Articles.dart';

class Api {
  String _baseUrl = 'http://newsapi.org/v2/top-headlines';

  Future<List<Articles>> getArticles(String title) async {
    String apikey = '&apiKey=7486fcd1083341b1a4d2b9c8540f1166';
    String cagt;
    if(title!=null){
      cagt = '?country=eg&category=$title';
    }
    else{
      cagt = '?country=eg';
    }
    var response = await http.get(_baseUrl + cagt + apikey);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Articles> aList = [];
      for (var item in data['articles']) {
        aList.add(Articles.fromJson(item));
      }
      //print(aList.length);
      return aList;
    }
    return null;
  }
}
