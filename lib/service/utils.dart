import 'package:intl/intl.dart';
import 'package:weather_forecast_for_learning_flutter/module/daily_weather.dart';

import '../module/weather_data.dart';
import 'current_weather_data.dart';
import 'current_weather_obj.dart';
import 'future_weather_data.dart';
import 'future_weather_obj.dart';

class Utils {
  static Future<Map<String, Object>> getCurrentWeatherDataArgs(
      {required String location,
      String latitude = "NONE",
      String longitude = "NONE"}) async {
    CurrentWeatherAPI currentWeatherAPI;
    ForecastData forecastData;
    if (latitude != "NONE" && longitude != "NONE") {
      currentWeatherAPI = CurrentWeatherAPI(
          location: location, latitude: latitude, longitude: longitude);
      forecastData = ForecastData(
          location: location, latitude: latitude, longitude: longitude);
    } else {
      currentWeatherAPI = CurrentWeatherAPI(location: location);
      forecastData = ForecastData(location: location);
    }
    await currentWeatherAPI.getWeatherData();
    await forecastData.getHourlyForecastData();

    WeatherData currentWeatherData =
        CurrentWeatherObj.getWeatherDataObj(currentWeatherAPI.data);
    List<WeatherData> weatherDataList =
        FutureWeatherObj.getWeatherDataObj(forecastData.hourlyForecastData);

    weatherDataList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return {
      "currentData": currentWeatherData,
      "hourlyData": weatherDataList,
      "units": "metric",
    };
  }

  static int getIntVal(dynamic data) {
    if (data is String) {
      return int.parse(data.substring(0, data.indexOf('.')));
    } else if (data is double) {
      return data.toInt();
    } else if (data is int) {
      return data;
    } else {
      return 0;
    }
  }

  static String getTimeInHHmm(int timestamp, int timezoneOffset) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        timestamp * 1000 + timezoneOffset * 1000,
        isUtc: true);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
  }

  static DateTime getDateTime(int timestamp, int timezoneOffset) {
    return DateTime.fromMillisecondsSinceEpoch(
        timestamp * 1000 + timezoneOffset * 1000,
        isUtc: true);
  }

  static List<DailyWeather> getDailyForecast(
      List<WeatherData> weatherForecast) {
    Map weekday = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };

    Map<String, DailyWeather> dailyWeatherMap = {};

    for (WeatherData weatherData in weatherForecast) {
      DailyWeather dailyWeather = DailyWeather(
          dateTime: weatherData.dateTime,
          day:
              '${DateFormat('dd MMM').format(weatherData.dateTime)}, ${weekday[weatherData.dateTime.weekday]}',
          pop: weatherData.pop,
          minTemp: weatherData.main.tempMin,
          maxTemp: weatherData.main.tempMax,
          iconImage: weatherData.iconImage);

      String key = DateFormat('dd MMM').format(weatherData.dateTime);

      if (!dailyWeatherMap.containsKey(key)) {
        dailyWeatherMap[key] = dailyWeather;
      } else {
        if (dailyWeatherMap[key]!.maxTemp < dailyWeather.maxTemp) {
          dailyWeatherMap[key]!.maxTemp = dailyWeather.maxTemp;
        }
        if (dailyWeatherMap[key]!.minTemp > dailyWeather.minTemp) {
          dailyWeatherMap[key]!.minTemp = dailyWeather.minTemp;
        }
        if (dailyWeatherMap[key]!.pop < dailyWeather.pop) {
          dailyWeatherMap[key]!.pop = dailyWeather.pop;
        }
      }
    }

    return dailyWeatherMap.values.toList();
  }
}
