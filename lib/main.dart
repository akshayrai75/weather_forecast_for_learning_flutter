import 'package:flutter/material.dart';
import 'package:weather_forecast_for_learning_flutter/pages/home_page.dart';
import 'package:weather_forecast_for_learning_flutter/pages/loading_page.dart';
import 'package:weather_forecast_for_learning_flutter/pages/error_page.dart';

ThemeData customTheme = ThemeData(
  brightness: Brightness.dark, // Set brightness to dark
  primaryColor: Colors.white, // Set primary color to white
  // scaffoldBackgroundColor: Colors.black, // Set scaffold background to black
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white), // Set body text color to white
    // ... other text styles ...
  ),
  iconTheme: const IconThemeData(color: Colors.white), // Set icon color to white
  // ... other theme properties ...
);

void main() => runApp(MaterialApp(
  theme: customTheme,
  initialRoute: '/',
  routes: {
    '/': (context) => LoadingPage(),
    '/home': (context) => HomePage(),
    '/error': (context) => ErrorPage()
  },
));