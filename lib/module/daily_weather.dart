import 'package:flutter/material.dart';

class DailyWeather {
  DateTime dateTime;
  String day;
  int pop;
  Image iconImage;
  int minTemp;
  int maxTemp;

  DailyWeather({
    required this.dateTime,
    required this.day,
    required this.pop,
    required this.minTemp,
    required this.maxTemp,
    required this.iconImage
  });
}