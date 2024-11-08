import 'package:http/http.dart';
import 'dart:convert';

import 'package:weather_forecast_for_learning_flutter/env/env.dart';

class ForecastData {
  String apiKey = Env.key;
  String location;
  String latitude;
  String longitude;
  Map hourlyForecastData = {};

  ForecastData(
      {this.location = 'Delhi',
      this.latitude = "NONE",
      this.longitude = "NONE"});

  //Hourly forecast only available for 5 days for every 3 hour
  Future<void> getHourlyForecastData() async {
    try {
      Response response;
      if (latitude != "NONE" && longitude != "NONE") {
        response = await get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?lat=${double.parse(latitude)}&lon=${double.parse(longitude)}&appid=$apiKey&units=metric"));
      } else {
        response = await get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey&units=metric"));
      }
      hourlyForecastData = jsonDecode(response.body);
    } catch (e) {
      hourlyForecastData = {"error": "Could not get Hourly Forecast Data."};
    }
  }
}
