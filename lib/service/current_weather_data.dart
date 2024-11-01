import 'package:http/http.dart';
import 'dart:convert';

import 'package:weather_forecast_for_learning_flutter/env/env.dart';

class CurrentWeatherAPI {
  String apiKey= Env.key;
  String location;
  Map data = {};

  CurrentWeatherAPI({this.location = 'Delhi'});

  Future<void> getWeatherData() async {
    try{
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric"));
      data = jsonDecode(response.body);
    }catch (e){
      print(e);
      data = {
        "error" : "Could not get weather data."
      };
    }
  }
}