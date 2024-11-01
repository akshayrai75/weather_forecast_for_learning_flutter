import 'package:flutter/material.dart';

class WeatherData {
  String cityName;
  String dt;
  DateTime dateTime;
  Main main;
  List<Weather> weather;
  Wind wind;
  int visibility;
  int pop;
  String dtTxt;
  int timezone;
  String sunrise;
  String sunset;
  Image iconImage;

  WeatherData(
      {required this.cityName,
      required this.dt,
      required this.dateTime,
      required this.main,
      required this.weather,
      required this.wind,
      required this.visibility,
      required this.pop,
      required this.dtTxt,
      required this.timezone,
      required this.sunrise,
      required this.sunset,
      required this.iconImage});
}

class Main {
  int temp;
  int feelsLike;
  int tempMin;
  int tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
  });
}

class Weather {
  String main;
  String description;
  String icon;
  String imageUrl;

  Weather(
      {
      required this.main,
      required this.description,
      required this.icon,
      required this.imageUrl});
}

class Wind {
  int speed;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
  });
}
