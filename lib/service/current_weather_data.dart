import 'package:http/http.dart';
import 'dart:convert';

import 'package:weather_forecast_for_learning_flutter/env/env.dart';

class CurrentWeatherAPI {
  String apiKey = Env.key;
  String location;
  String latitude;
  String longitude;
  Map data = {};

  CurrentWeatherAPI(
      {this.location = 'Bangalore',
      this.latitude = "NONE",
      this.longitude = "NONE"});

  Future<void> getWeatherData() async {
    try {
      Response response;
      if (latitude != "NONE" && longitude != "NONE") {
        response = await get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=${double.parse(latitude)}&lon=${double.parse(longitude)}&appid=$apiKey&units=metric"));
      } else {
        response = await get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric"));

      }
      data = jsonDecode(response.body);
    } catch (e) {
      data = {"error": "Could not get weather data."};
    }
  }
}
