import 'package:http/http.dart';
import 'dart:convert';

import 'package:weather_forecast_for_learning_flutter/env/env.dart';

class ForecastData {
  String apiKey= Env.key;
  String location;
  Map hourlyForecastData = {};

  ForecastData({this.location = 'Delhi'});

  //Hourly forecast only available for 5 days for every 3 hour
  Future<void> getHourlyForecastData() async {
    try{
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey&units=metric"));
      hourlyForecastData = jsonDecode(response.body);
    }catch (e){
      print(e);
      hourlyForecastData = {
        "error" : "Could not get Hourly Forecast Data."
      };
    }
  }
}