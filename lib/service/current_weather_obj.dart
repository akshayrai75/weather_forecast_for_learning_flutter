import 'package:flutter/material.dart';
import 'package:weather_forecast_for_learning_flutter/service/utils.dart';

import '../module/weather_data.dart';

class CurrentWeatherObj{

  static WeatherData getWeatherDataObj(Map data) {
    Main mainData = getMain(data['main']);
    List<Weather> weatherList = getWeather(data['weather']);
    Wind windData = getWind(data['wind']);

    return WeatherData(
        cityName: data['name'],
        dt: Utils.getTimeInHHmm(data['dt'], data['timezone']),
        dateTime: Utils.getDateTime(data['dt'], data['timezone']),
        main: mainData,
        weather: weatherList,
        wind: windData,
        visibility: data['visibility'],
        pop: 0,
        dtTxt: Utils.getTimeInHHmm(data['dt'], data['timezone']),
        timezone: data['timezone'],
        sunrise: Utils.getTimeInHHmm(data['sys']['sunrise'], data['timezone']),
        sunset: Utils.getTimeInHHmm(data['sys']['sunset'], data['timezone']),
        iconImage: Image.network(weatherList[0].imageUrl, width: 90, height: 90,)
    );
  }

  static Main getMain(Map mainData) {
    Main mainWeatherData = Main(
      temp: Utils.getIntVal(mainData['temp']),
      feelsLike: Utils.getIntVal(mainData['feels_like']),
      tempMin: Utils.getIntVal(mainData['temp_min']),
      tempMax: Utils.getIntVal(mainData['temp_max']),
      pressure: mainData['pressure'],
      seaLevel: mainData['sea_level'],
      grndLevel: mainData['grnd_level'],
      humidity: mainData['humidity'],
    );

    return mainWeatherData;
  }

  static List<Weather> getWeather(List weatherMap) {
    List<Weather> weatherList = [];
    for (var weatherJson in weatherMap) {
      weatherList.add(Weather(
        main: weatherJson['main'],
        description: weatherJson['description'],
        icon: weatherJson['icon'],
        imageUrl: 'https://openweathermap.org/img/wn/${weatherJson['icon']}@2x.png'
      ));
    }
    return weatherList;
  }

  static Wind getWind(Map windData) {
    Wind windWeatherData = Wind(
        speed: Utils.getIntVal(windData['speed']),
        deg: windData['deg'],
    );

    return windWeatherData;
  }
}