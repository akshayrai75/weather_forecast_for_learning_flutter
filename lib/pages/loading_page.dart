import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../service/utils.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void setupCurrentWeatherData() async {
    Position position;
    try {
      position = await _determinePosition();
      Navigator.pushReplacementNamed(context, '/home',
          arguments: await Utils.getCurrentWeatherDataArgs(
              location: "Bangalore",
              latitude: position.latitude.toString(),
              longitude: position.longitude.toString()));
    } catch (e) {
      try {
        Navigator.pushReplacementNamed(context, '/home',
            arguments:
                await Utils.getCurrentWeatherDataArgs(location: "Bangalore"));
      } catch (e2) {
        Navigator.pushNamed(context, '/error',
            arguments: {'error' : e2.toString()}
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setupCurrentWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: SpinKitSpinningLines(
        color: Colors.white,
        size: 50,
      ),
    ));
  }
}
