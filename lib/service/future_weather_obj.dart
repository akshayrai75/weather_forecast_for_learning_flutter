import 'package:flutter/material.dart';
import 'package:weather_forecast_for_learning_flutter/service/current_weather_obj.dart';
import 'package:weather_forecast_for_learning_flutter/service/utils.dart';

import '../module/weather_data.dart';

class FutureWeatherObj{

  static List<WeatherData> getWeatherDataObj(Map data) {

    List<WeatherData> weatherDataList = [];
    int timezone = data['city']['timezone'];

    for (var weatherJson in data['list']) {
      Main mainData = CurrentWeatherObj.getMain(weatherJson['main']);
      List<Weather> weatherList = CurrentWeatherObj.getWeather(weatherJson['weather']);
      Wind windData = CurrentWeatherObj.getWind(weatherJson['wind']);

      weatherDataList.add(WeatherData(
          cityName: data['city']['name'],
          dt: Utils.getTimeInHHmm(weatherJson['dt'], timezone),
          dateTime: Utils.getDateTime(weatherJson['dt'], timezone),
          main: mainData,
          weather: weatherList,
          wind: windData,
          visibility: weatherJson['visibility'],
          pop: (weatherJson['pop']*100).toInt(),
          dtTxt: weatherJson['dt_txt'],
          timezone: timezone,
          sunrise: Utils.getTimeInHHmm(data['city']['sunrise'], timezone),
          sunset: Utils.getTimeInHHmm(data['city']['sunset'], timezone),
          iconImage: Image.network(weatherList[0].imageUrl, width: 45, height: 45,)
      ));
    }

    return weatherDataList;
  }
}