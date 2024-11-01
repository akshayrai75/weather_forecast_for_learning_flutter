import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_forecast_for_learning_flutter/module/weather_data.dart';
import 'package:weather_forecast_for_learning_flutter/service/current_weather_data.dart';
import 'package:weather_forecast_for_learning_flutter/service/current_weather_obj.dart';
import 'package:weather_forecast_for_learning_flutter/service/future_weather_data.dart';
import 'package:weather_forecast_for_learning_flutter/service/future_weather_obj.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  void setupCurrentWeatherData() async {
    CurrentWeatherAPI currentWeatherAPI = CurrentWeatherAPI(
        location: "Bangalore"
    );
    ForecastData forecastData = ForecastData(
      location: "Bangalore"
    );
    await currentWeatherAPI.getWeatherData();
    await forecastData.getHourlyForecastData();

    WeatherData currentWeatherData = CurrentWeatherObj.getWeatherDataObj(currentWeatherAPI.data);
    List<WeatherData> weatherDataList = FutureWeatherObj.getWeatherDataObj(forecastData.hourlyForecastData);

    weatherDataList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      "currentData": currentWeatherData,
      // "hourlyData": {},
      "hourlyData": weatherDataList,
      // "dailyData": forecastData.dailyForecastData
      "units":"metric",
      // "iconImage": iconImage
    });
  }

  @override
  void initState() {
    super.initState();
    setupCurrentWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(
      child: SpinKitSpinningLines(
        color: Colors.white,
        size: 50,
      ),
    ));
  }
}
