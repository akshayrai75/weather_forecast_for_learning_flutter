import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_for_learning_flutter/module/daily_weather.dart';
import 'package:weather_forecast_for_learning_flutter/module/weather_data.dart';
import 'package:weather_forecast_for_learning_flutter/service/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _inputValue = '';

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    WeatherData currentWeatherData = data['currentData'];

    bool isImperial = data['units'] == "imperial";
    String temperatureUnit = isImperial ? "°F" : "°C";
    String speedUnit = isImperial ? "miles/hr" : "m/s";

    List<Color> bgColor = isDayTime(currentWeatherData.dt,
            currentWeatherData.sunrise, currentWeatherData.sunset)
        ? [Colors.blue[100]!, Colors.blue.shade500]
        : [Colors.indigo[600]!, Colors.deepPurple[800]!];

    Color? innerBgColor = isDayTime(currentWeatherData.dt,
            currentWeatherData.sunrise, currentWeatherData.sunset)
        ? Colors.blueAccent
        : Colors.deepPurple[900];

    List<WeatherData> weatherForecast = data['hourlyData'];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: bgColor,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: IntrinsicWidth(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                _inputValue = text;
                              });
                            },
                            style: TextStyle(
                              color: Colors.black54
                            ),
                            decoration: InputDecoration(
                                hintText: currentWeatherData.cityName,
                                hintStyle: TextStyle(
                                  color: Colors.black54
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.search_circle, size: 60),
                        onPressed: () async {
                          Navigator.pushReplacementNamed(context, '/home',
                              arguments: await Utils.getCurrentWeatherDataArgs(
                                  location: _inputValue));
                          // dynamic result = await setupCurrentWeatherData(_inputValue);
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Last Updated on: ',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        currentWeatherData.dt,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${currentWeatherData.main.temp}$temperatureUnit',
                            style: TextStyle(
                              fontSize: 45,
                            ),
                          ),
                          currentWeatherData.iconImage,
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            currentWeatherData.weather[0].description,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Feels: ${currentWeatherData.main.feelsLike}$temperatureUnit',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Max: ${currentWeatherData.main.tempMax}$temperatureUnit',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '  |  Min: ${currentWeatherData.main.tempMin}$temperatureUnit',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IntrinsicWidth(
                          child: _buildDataContainer(
                              getIcon("visibility", 24.0),
                              'Visibility',
                              '${currentWeatherData.visibility / 1000} Km',
                              innerBgColor),
                        ),
                      ),
                      Expanded(
                        child: IntrinsicWidth(
                          child: _buildDataContainer(
                              getIcon("humidity", 24.0),
                              'Humidity',
                              '${currentWeatherData.main.humidity}%',
                              innerBgColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IntrinsicWidth(
                          child: _buildDataContainer(
                              getIcon("wind", 24.0),
                              'Wind Speed',
                              '${currentWeatherData.wind.speed} $speedUnit',
                              innerBgColor),
                        ),
                      ),
                      Expanded(
                        child: IntrinsicWidth(
                          child: _buildDataContainer(
                              getIcon("direction", 24.0),
                              'Wind Direction',
                              '${currentWeatherData.wind.deg}°',
                              innerBgColor),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: innerBgColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.sunrise_fill,
                              color: Colors.amber,
                              size: 50,
                            ),
                            Text(
                              currentWeatherData.sunrise,
                              style: TextStyle(fontSize: 25),
                            ),
                            Text("Sunrise")
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.sunset_fill,
                              color: Colors.orange,
                              size: 50,
                            ),
                            Text(
                              currentWeatherData.sunset,
                              style: TextStyle(fontSize: 25),
                            ),
                            Text("Sunrise")
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('3 hours Forecast'),
                  _buildWeatherForecastRow(weatherForecast, innerBgColor),
                  SizedBox(height: 10.0),
                  Text('Daily Forecast'),
                  _buildWeatherForecastCol(weatherForecast, innerBgColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataContainer(
      Icon icon, String dataLabel, String data, Color? bgColor) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.blue[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 8.0,
              ),
              Text(dataLabel),
            ],
          ),
          Text(
            data,
            style: TextStyle(fontSize: 25.0),
          )
        ],
      ),
    );
  }

  bool isDayTime(String currTime, String sunrise, String sunset) {
    DateTime currHrMin = DateFormat('HH:mm').parse(currTime);
    DateTime riseHrMin = DateFormat('HH:mm').parse(sunrise);
    DateTime setHrMin = DateFormat('HH:mm').parse(sunset);

    return currHrMin.hour >= riseHrMin.hour && currHrMin.hour < setHrMin.hour
        ? true
        : false;
  }

  Icon getIcon(String iconName, double iconSize) {
    switch (iconName) {
      case "wind":
        return Icon(
          CupertinoIcons.wind,
          size: iconSize,
        );
      case "visibility":
        return Icon(
          CupertinoIcons.eye,
          size: iconSize,
        );
      case "humidity":
        return Icon(
          CupertinoIcons.drop,
          size: iconSize,
        );
      case "direction":
        return Icon(
          CupertinoIcons.location,
          size: iconSize,
        );
      case "weather":
        return Icon(
          CupertinoIcons.cloud_sun,
          size: iconSize,
        );
      default:
        return Icon(
          CupertinoIcons.question_diamond,
          size: iconSize,
        );
    }
  }

  Widget _buildWeatherForecastRow(
      List<WeatherData> weatherForecast, Color? bgColor) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: bgColor ?? Colors.blue[800],
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 180,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: weatherForecast.length,
              itemBuilder: (context, index) {
                final weatherData = weatherForecast[index];
                final formattedDateTime =
                    DateFormat('dd MMM').format(weatherData.dateTime);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(weatherData.dt),
                      Text('${weatherData.pop.toString()}%'),
                      weatherData.iconImage,
                      Text(
                        '${weatherData.main.temp}°',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(formattedDateTime),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherForecastCol(
      List<WeatherData> weatherForecast, Color? bgColor) {
    List<DailyWeather> dailyWeatherList =
        Utils.getDailyForecast(weatherForecast);
    dailyWeatherList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Column(
      children: dailyWeatherList.map((weatherData) {
        return Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
          decoration: BoxDecoration(
            color: bgColor ?? Colors.blue[800],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(weatherData.day),
              Row(
                children: [Text('${weatherData.pop}%'), weatherData.iconImage],
              ),
              Text('${weatherData.minTemp}°/${weatherData.maxTemp}°')
            ],
          ),
        );
      }).toList(),
    );
  }
}
