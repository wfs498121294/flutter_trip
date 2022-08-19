
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/home_model.dart';

// const homeUrl = "https://www.devio.org/io/flutter_app/json/home_page.json";

class HomeDao {

  var url = Uri.https('devio.org', '/io/flutter_app/json/home_page.json');

  Future<HomeModel> fetch() async {

    print(url);
    final response = await http.get(url);

    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = const Utf8Decoder(); // 转码中文
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print(result);
      return HomeModel.fromJson(result);
    }
    else{
      throw Exception("Failded to load home_page.json");
    }


  }


}